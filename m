Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jul 2007 23:47:23 +0100 (BST)
Received: from wa-out-1112.google.com ([209.85.146.183]:50518 "EHLO
	wa-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20021953AbXGKWrV (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 11 Jul 2007 23:47:21 +0100
Received: by wa-out-1112.google.com with SMTP id m16so2293596waf
        for <linux-mips@linux-mips.org>; Wed, 11 Jul 2007 15:47:08 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=R9Fbs9xtHJlUVgZtrKOsdfZrmjP5Sreq2FS2xYcDElHG9pqbSM/sqludV/cD+rl2MH/mBKvgbVbd8tJkM5h69KwpPkLiq/u9dzJzogSzIF0cLV3m3Wtub2ImQyFvyRxKLJOMSywnc04ZbZlNEEWWntRKTUbfzr8kclnOWRSA9mo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=EooO1oE755lMgNNHn7ggUAiKl1wDifaPQDzEOmPkuiYnjLo6kccFD8JCFKJrfspGsMyDYNZqb5EevPcxbSfhCZV47SxkINnPzxmAT5k/rxF+17ftCrg0blpaEbawydZSa38UDxNp1b00U49WmlYIuiTYJOuRljHT8x7ptHcSDTM=
Received: by 10.115.22.1 with SMTP id z1mr5561451wai.1184193996661;
        Wed, 11 Jul 2007 15:46:36 -0700 (PDT)
Received: by 10.114.110.6 with HTTP; Wed, 11 Jul 2007 15:46:36 -0700 (PDT)
Message-ID: <b2b2f2320707111546p5b7e1c6dv60a8d600a28634e7@mail.gmail.com>
Date:	Wed, 11 Jul 2007 16:46:36 -0600
From:	"Shane McDonald" <mcdonald.shane@gmail.com>
To:	"Robert P. J. Day" <rpjday@mindspring.com>
Subject: Re: latest list of apparently "dead" CONFIG variables under arch/mips
Cc:	linux-mips@linux-mips.org
In-Reply-To: <Pine.LNX.4.64.0707111437480.12345@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_11532_12641585.1184193996642"
References: <Pine.LNX.4.64.0707111437480.12345@localhost.localdomain>
Return-Path: <mcdonald.shane@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15717
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mcdonald.shane@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_11532_12641585.1184193996642
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The following are not "just pure junk", as PMC-Sierra is working on
providing acceptable code that supports their MSP71xx processors.  Patches
to remove these are not required!

On 7/11/07, Robert P. J. Day <rpjday@mindspring.com> wrote:
>
> ========== PMCTWILED ==========
> arch/mips/configs/msp71xx_defconfig:941:CONFIG_PMCTWILED=y
> arch/mips/pmc-sierra/msp71xx/msp_hwbutton.c:35:#ifdef CONFIG_PMCTWILED
> arch/mips/pmc-sierra/msp71xx/msp_hwbutton.c:85:#ifdef CONFIG_PMCTWILED
> arch/mips/pmc-sierra/msp71xx/msp_hwbutton.c:97:#ifdef CONFIG_PMCTWILED
> arch/mips/pmc-sierra/msp71xx/msp_setup.c:249:#ifdef CONFIG_PMCTWILED
> ========== SQUASHFS ==========
> arch/mips/configs/msp71xx_defconfig:1307:CONFIG_SQUASHFS=y
> arch/mips/pmc-sierra/msp71xx/msp_prom.c:46:#ifdef CONFIG_SQUASHFS
> arch/mips/pmc-sierra/msp71xx/msp_prom.c:552:#ifdef CONFIG_SQUASHFS
> arch/mips/pmc-sierra/msp71xx/msp_prom.c:554:            /* Get SQUASHFS
> size */
>

Shane McDonald

------=_Part_11532_12641585.1184193996642
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The following are not &quot;just pure junk&quot;, as PMC-Sierra is working on providing acceptable code that supports their MSP71xx processors.&nbsp; Patches to remove these are not required!<br><br><div><span class="gmail_quote">
On 7/11/07, <b class="gmail_sendername">Robert P. J. Day</b> &lt;<a href="mailto:rpjday@mindspring.com">rpjday@mindspring.com</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
========== PMCTWILED ==========<br>arch/mips/configs/msp71xx_defconfig:941:CONFIG_PMCTWILED=y<br>arch/mips/pmc-sierra/msp71xx/msp_hwbutton.c:35:#ifdef CONFIG_PMCTWILED<br>arch/mips/pmc-sierra/msp71xx/msp_hwbutton.c:85:#ifdef CONFIG_PMCTWILED
<br>arch/mips/pmc-sierra/msp71xx/msp_hwbutton.c:97:#ifdef CONFIG_PMCTWILED<br>arch/mips/pmc-sierra/msp71xx/msp_setup.c:249:#ifdef CONFIG_PMCTWILED<br>========== SQUASHFS ==========<br>arch/mips/configs/msp71xx_defconfig:1307:CONFIG_SQUASHFS=y
<br>arch/mips/pmc-sierra/msp71xx/msp_prom.c:46:#ifdef CONFIG_SQUASHFS<br>arch/mips/pmc-sierra/msp71xx/msp_prom.c:552:#ifdef CONFIG_SQUASHFS<br>arch/mips/pmc-sierra/msp71xx/msp_prom.c:554:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/* Get SQUASHFS size */
<br></blockquote></div><br>Shane McDonald<br>

------=_Part_11532_12641585.1184193996642--
