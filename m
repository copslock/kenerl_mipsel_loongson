Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Oct 2007 13:51:58 +0100 (BST)
Received: from py-out-1112.google.com ([64.233.166.183]:26765 "EHLO
	py-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20024870AbXJLMvu (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 12 Oct 2007 13:51:50 +0100
Received: by py-out-1112.google.com with SMTP id p76so1658668pyb
        for <linux-mips@linux-mips.org>; Fri, 12 Oct 2007 05:51:31 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type;
        bh=qf1Tw3Onty+BwLeXN5TMRpAUQQJrnSFLkPGcqp3p5cM=;
        b=deEHNXDkqbpAZeyrCrwOZ1g2MYkTQGfp8kL1WJSgan1XF0JQFupOyPChotQMRW8sAkGL8Hodm6EINPPxm1g2jh05VF0C2YSGc6LuB5KxZDpGp3TI9A2H2HtZibzAOHZZsUaoj68Yk+5O1KRFfRYhgpHbP0ugvCkZrzoFwIYOHog=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=dhBGG6hE55TbnyUltH3ghBpTGuAiW6k2s1hV7WKqyqxBpj8xbk48G54X/OQX5odq0K8s0tJsgwrj5myF4I+CRfqWVzPzqaod5/O5/IvuW7TtHm5Hjh3uN6a73cm68QsNle0Jbrm9MFryqSBPg/t96MTc8uXyvxNyDYXeFvFKQIs=
Received: by 10.35.27.1 with SMTP id e1mr3643211pyj.1192193491616;
        Fri, 12 Oct 2007 05:51:31 -0700 (PDT)
Received: by 10.35.39.19 with HTTP; Fri, 12 Oct 2007 05:51:31 -0700 (PDT)
Message-ID: <eea8a9c90710120551x66311e20pfd639edb9daf68fc@mail.gmail.com>
Date:	Fri, 12 Oct 2007 18:21:31 +0530
From:	kaka <share.kt@gmail.com>
To:	linux-mips@linux-mips.org
Subject: Unknown symbol register_framebuffer
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_63689_15257958.1192193491611"
Return-Path: <share.kt@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16984
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: share.kt@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_63689_15257958.1192193491611
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

>
> Hi All,
>
> WHile installing framebuffer driver for BCM chip in MIPS platform(cross
> compiled in intel 86).
> I am getting the following error.
>

Since it is cross compiled and running on MIPS platform, the linux doesn't
support modinfo command to find the dependencies.

 Can somebody help in this regard?
> Thanks in Advance.
>
> # insmod brcmstfb.ko
> brcmstfb: Unknown symbol unregister_framebuffer
> brcmstfb: Unknown symbol printf
> brcmstfb: Unknown symbol __make_dp
> brcmstfb: Unknown symbol malloc
> brcmstfb: Unknown symbol framebuffer_alloc
> brcmstfb: Unknown symbol fb_find_mode
> brcmstfb: Unknown symbol fb_dealloc_cmap
> brcmstfb: Unknown symbol brcm_dir_entry
> brcmstfb: Unknown symbol register_framebuffer
> brcmstfb: Unknown symbol fb_alloc_cmap
> brcmstfb: Unknown symbol framebuffer_release
> brcmstfb: Unknown symbol free
>
> --
> Thanks & Regards,
> kaka
>



-- 
Thanks & Regards,
kaka

------=_Part_63689_15257958.1192193491611
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div>Hi All,</div>
<div>&nbsp;</div>
<div>WHile installing framebuffer driver for BCM chip in MIPS platform(cross compiled in intel 86).</div>
<div>I am getting the following error.</div></blockquote>
<div>&nbsp;</div>
<div>Since it is cross compiled and running on MIPS platform, the linux doesn&#39;t support modinfo command to find the dependencies.</div><br>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div>Can somebody help in this regard?</div>
<div>Thanks in Advance.</div>
<div>&nbsp;</div>
<div># insmod brcmstfb.ko<br>brcmstfb: Unknown symbol unregister_framebuffer<br>brcmstfb: Unknown symbol printf<br>brcmstfb: Unknown symbol __make_dp<br>brcmstfb: Unknown symbol malloc<br>brcmstfb: Unknown symbol framebuffer_alloc 
<br>brcmstfb: Unknown symbol fb_find_mode<br>brcmstfb: Unknown symbol fb_dealloc_cmap<br>brcmstfb: Unknown symbol brcm_dir_entry<br>brcmstfb: Unknown symbol register_framebuffer<br>brcmstfb: Unknown symbol fb_alloc_cmap<br>
brcmstfb: Unknown symbol framebuffer_release<br>brcmstfb: Unknown symbol free<br><br>-- <br>Thanks &amp; Regards,<br>kaka </div></blockquote></div><br><br clear="all"><br>-- <br>Thanks &amp; Regards,<br>kaka 

------=_Part_63689_15257958.1192193491611--
