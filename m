Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Jan 2016 19:00:41 +0100 (CET)
Received: from mail-ig0-f193.google.com ([209.85.213.193]:33331 "EHLO
        mail-ig0-f193.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011283AbcA1SAjmRFwq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 Jan 2016 19:00:39 +0100
Received: by mail-ig0-f193.google.com with SMTP id h5so2199621igh.0;
        Thu, 28 Jan 2016 10:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=XQ0sGwkV/pvV0p1mNon5R+EykKEARpyA1gAQxmhwKls=;
        b=g/iTM8PDYUF5tR/nHxpSyF4Lzy9xIyAEhJmkp2R5F9l/fruxVSxlEp04DXMxEtN1EE
         Wg6d+6EX0d1rViOn3NMCNnT3iNBSeyEBkFYDHI9kNf0U/Po97n6XUv8zCTHB9CAfZdlG
         Nf4aGQb0LR0zFqh7WDy/xc1wsMeacUP13zkHlCEJ9pgc0MjPX1hDcvrKkFc7yhEriAEp
         AjfC1UPqBI2JoVf2Crf/Tb/oYrdxGLg4yu4AiaMqiP/2vr38pJvADtLhhHv8iRyBzlQC
         IQ3GoIkWMqDfyYFQHtXn7RGg5zlsWbNAhHhM2KtRR32OeJ6OUM5zBvCPAxHkhDgOPC6q
         u3og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=XQ0sGwkV/pvV0p1mNon5R+EykKEARpyA1gAQxmhwKls=;
        b=cPfM5NCeu2T3GHqzx5u3mdHZX12Wya+F6KJAXSnemKRdMDVqclBCoIGIDkiKtwwIcB
         vEhoLvbqVlqTCBFVrFmiWtnwulccm9q2Z2AlhN2olY8jM4jAC2RfXJQ5gY3sjcdKdpFY
         q3zm0I2ZISLdFs4pWLOUzf21kL/HHBuwlf7ulRoc+PXLbKX7Bb7dyy4cgh20pm0FwjJY
         FKIBCc/OGKeFzprUyjrBSVD+T/MyZDIPk9DzotfihSLSUxXZLUY5uaAWlYR2XQLtgV/3
         eXoe8NN4NovR7g7heqLQt7N1I0TdBLRGVqwtNQhLa+kVRAHXbA+HDhsqPF80+yZ/LF96
         CWoA==
X-Gm-Message-State: AG10YOSaXYZOzsgRx75Q7FN//DvigBiv8V/3mWqqyDtn019jddDSLayc3uWlxc4+FHa5imQ3fLavbesT+/mZEQ==
MIME-Version: 1.0
X-Received: by 10.50.136.227 with SMTP id qd3mr4952951igb.38.1454004030840;
 Thu, 28 Jan 2016 10:00:30 -0800 (PST)
Received: by 10.107.9.97 with HTTP; Thu, 28 Jan 2016 10:00:30 -0800 (PST)
In-Reply-To: <3596300.IYfzmako0c@wuerfel>
References: <569e1dbb.MgLv8OaZwklOxxtU%fengguang.wu@intel.com>
        <1947556.38OyJnvGS5@wuerfel>
        <20160127093018.GA21190@wfg-t540p.sh.intel.com>
        <3596300.IYfzmako0c@wuerfel>
Date:   Thu, 28 Jan 2016 19:00:30 +0100
X-Google-Sender-Auth: Sr_kCKuOWTzDk5KsttyKTvn2RbY
Message-ID: <CAMuHMdWCwP8Hkn+tGEoG-FxUnjAq8uExcPhmXASh_ErU8DDN2w@mail.gmail.com>
Subject: Re: [linux-review:James-Hogan/kbuild-Remove-stale-asm-generic-wrappers/20160119-183642]
 d979f99e9cc14e2667e9b6e268db695977e4197a BUILD DONE
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Fengguang Wu <fengguang.wu@intel.com>,
        James Hogan <james.hogan@imgtec.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Marek <mmarek@suse.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51511
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
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

Hi Arnd,

On Wed, Jan 27, 2016 at 10:44 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> - in some configurations, you end up without any boards selected, hitting
>   an #error in the final link

FWIW, I have a similar problem with m68k+MMU=y randconfig...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
