Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Dec 2015 17:29:41 +0100 (CET)
Received: from mail-yk0-f175.google.com ([209.85.160.175]:34566 "EHLO
        mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008993AbbL1Q3juRN2R (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 28 Dec 2015 17:29:39 +0100
Received: by mail-yk0-f175.google.com with SMTP id a85so30480368ykb.1;
        Mon, 28 Dec 2015 08:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=LLwV/WFmiJJV5wLRERksZD2ZPDTpAqBVR3Id6C7F4jk=;
        b=e3BKySUD7Fpsm6JqK0YmOUdYOaBaRcnbYB7OupFB9jL2eV8LQw/HEuNpW9Lt+dElJV
         g02BYT5hqrp4D01u3tawmFWDT6UD4EfIKHeJ33VJDZvLj914SlifqpBbS5NnrsXsTYLS
         OY8qxbN11bKuHJfXdjUzpeUGAwNbvuSvT/OyISuJ3N/2yMEKVeXGZj3ujmRmb5sOg8HQ
         Cl5hc6hej3SujRVnBynRbjykCts0G1j25T3NevZDI8AKDi70oc1XVBrBALIygrxqOVLi
         jI4xFqhACfSjzofnf0jui4v1VKaeWz6H9y1ADG0ZVRWvRiGuudlIGeFiyB9phPUQJco9
         fB5A==
X-Received: by 10.129.0.136 with SMTP id 130mr19365589ywa.81.1451320174156;
        Mon, 28 Dec 2015 08:29:34 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::d:d535])
        by smtp.gmail.com with ESMTPSA id i67sm1543234ywf.34.2015.12.28.08.29.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Dec 2015 08:29:33 -0800 (PST)
Date:   Mon, 28 Dec 2015 11:29:33 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Alex Smith <alex.smith@imgtec.com>,
        Markos Chandras <Markos.Chandras@imgtec.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: Build regressions/improvements in v4.4-rc7
Message-ID: <20151228162933.GV5003@mtj.duckdns.org>
References: <1451305281-3911-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdWnSERAHcxDV47FRY1Sz6XJku72xRPb1cGig7sSF8nf4A@mail.gmail.com>
 <20151228161839.GS5003@mtj.duckdns.org>
 <568161BC.3060208@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <568161BC.3060208@infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <htejun@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50767
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tj@kernel.org
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

Hello,

On Mon, Dec 28, 2015 at 08:22:20AM -0800, Randy Dunlap wrote:
> On 12/28/15 08:18, Tejun Heo wrote:
> > On Mon, Dec 28, 2015 at 01:29:18PM +0100, Geert Uytterhoeven wrote:
> >> On Mon, Dec 28, 2015 at 1:21 PM, Geert Uytterhoeven
> >> <geert@linux-m68k.org> wrote:
> >>> JFYI, when comparing v4.4-rc7[1] to v4.4-rc6[3], the summaries are:
> >>>   - build errors: +14/-3
> >>
> >>   + /home/kisskb/slave/src/include/linux/kqueue.h: error:
> >> dereferencing type-punned pointer will break strict-aliasing rules
> >> [-Werror=strict-aliasing]:  => 186:2
> > 
> > kqueue.h?
> > 
> 
>   + /home/kisskb/slave/src/include/linux/workqueue.h: error: dereferencing type-punned pointer will break strict-aliasing rules [-Werror=strict-aliasing]:  => 186:2

Heh, yeah, that makes a lot more sense.  At the same time tho, the
code has been there forever and there are a lot of simliar derefs
throughout kernel/workqueue.c.  Is there something the code should be
doing?

Thanks.

-- 
tejun
