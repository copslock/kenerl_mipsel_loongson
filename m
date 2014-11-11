Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Nov 2014 12:26:08 +0100 (CET)
Received: from mail-ie0-f178.google.com ([209.85.223.178]:45064 "EHLO
        mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013368AbaKKL0FwdCGO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 11 Nov 2014 12:26:05 +0100
Received: by mail-ie0-f178.google.com with SMTP id rp18so10924913iec.23
        for <multiple recipients>; Tue, 11 Nov 2014 03:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=hneSRsAWYGEFQnm24LTaY/MfGJWKeQzAu5ooVSIcScI=;
        b=0FhlDGauNExXVrfSursGowfVU251Euoawb/Daj5RcbGB+FIkkpXSNB60FVGGYlJsRP
         GZrbi6KRayIV5UJpalImdJiOjN65qkw1yqADALiT/XruuXV+5PtWGDt/BKiCE/IdBs4l
         mhe3bL48VdKppcKRg/PimsNz5MZdakqrGxtQN3l3MF/STxf6Pab47p5Y1YsMK+e5pNBR
         YS6QigMMZHWUbm+KRj9g52IT//vAy3Sis2qXfEq0wJWpQvmf1gP3+qAVIrc5vbMrQ0G0
         r2A5KQ7N/NhFUFL0lZLwg+v2W68nnpSbuWbm+8F2/LM6HhRUqU7fYFSgELLMkNQg0lrZ
         WL5w==
MIME-Version: 1.0
X-Received: by 10.42.37.138 with SMTP id y10mr41102971icd.26.1415705159254;
 Tue, 11 Nov 2014 03:25:59 -0800 (PST)
Received: by 10.64.176.211 with HTTP; Tue, 11 Nov 2014 03:25:59 -0800 (PST)
In-Reply-To: <20141111110702.GA28822@linux-mips.org>
References: <1415081928-25899-1-git-send-email-chenhc@lemote.com>
        <20141111105748.GK27259@linux-mips.org>
        <CAAhV-H7H+7TYyvbecaS6C1NEq7DEnjez2Z_eHnpix0+m_5FDoA@mail.gmail.com>
        <20141111110702.GA28822@linux-mips.org>
Date:   Tue, 11 Nov 2014 19:25:59 +0800
X-Google-Sender-Auth: lKs_ZnJTURhuNNn3pfK5BfUbP8E
Message-ID: <CAAhV-H6T71WzgAcDPYePO2onT9h1PBDjyX8BuCwZGi9V+wLh6g@mail.gmail.com>
Subject: Re: [PATCH V2 12/12] MIPS: Loongson: Make CPUFreq usable for Loongson-3
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-pm@vger.kernel.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Hongliang Tao <taohl@lemote.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43997
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Hi, Ralf,

I hope I didn't misunderstand your meaning...
If all cores share the same clockrate (like Loongson-3A), then CPUFreq
driver should update all core's udelay_val (include the offline core's
udelay_val) at frequency changing. If each core has its own clockrate
(like Loongson-3B), the new online core can use its old udelay_val
when online. In any case, we don't use loops_per_jiffy for CPU
hotplug. Maybe you need to see set_shared_udelay_val() in my patch.

Huacai

On Tue, Nov 11, 2014 at 7:07 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Tue, Nov 11, 2014 at 07:02:48PM +0800, Huacai Chen wrote:
>
>> Loops_per_jiffy is set on startup and doesn't change later. It reflect
>> the maximum value frequency, but for CPU hotplug, a new online CPU may
>> not run at the maximum frequency (remain the old value before it is
>> offline).
>
> As suspected.  But what if a CPU is hotunplugged, then the clockrate
> for all the CPUs changes and then the gets re-hotplugged into the system.
> Wouldn't in that case the udelay_val be used?
>
>   Ralf
>
