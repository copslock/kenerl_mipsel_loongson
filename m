Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Oct 2007 13:45:59 +0100 (BST)
Received: from py-out-1112.google.com ([64.233.166.182]:35238 "EHLO
	py-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20022181AbXJJMpv (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 10 Oct 2007 13:45:51 +0100
Received: by py-out-1112.google.com with SMTP id p76so349758pyb
        for <linux-mips@linux-mips.org>; Wed, 10 Oct 2007 05:45:30 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type;
        bh=CQyB/BzZ7Y6tIhEq0r9aEiqZ14Dpywy7BB4Z9IBzPjg=;
        b=K8Thad1Dm5rhUdAH1cUqhGWOuSfe1RGGYcrQg0nInDnYENhmfN45wfG9bNVKqsiUbJ1arE+fhA6S1GAksxLDBIjRqt2G7+EA4uMCfk1+YgI/3OBfyWl5SfssdYYvPl8W6BIaD8dSWu7zIQLMem6xxrPQk4dfXxbIuaS7lKMFXX4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=XmmkZNgovwFpkYlbMl0VivecW5Ov0NoY4WulYGwOZ34izxj+W9QB7wFGMZ2GL3ZO0p6b8fc6egmHmyTpWm7VnFSUap8QJah8IXEM9X5MdwTvZKeNXUSysDyokKDTUIDgXystieK5zvZxVFLfpbXHRyod4ciDyBoC7KBfbzpGX2k=
Received: by 10.35.96.11 with SMTP id y11mr798761pyl.1192020330039;
        Wed, 10 Oct 2007 05:45:30 -0700 (PDT)
Received: by 10.35.39.19 with HTTP; Wed, 10 Oct 2007 05:45:29 -0700 (PDT)
Message-ID: <eea8a9c90710100545y35d69e0ck96787609a935a889@mail.gmail.com>
Date:	Wed, 10 Oct 2007 18:15:29 +0530
From:	kaka <share.kt@gmail.com>
To:	linux-mips@linux-mips.org
Subject: Unknown symbol errors in insmod <driver name>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_54036_31414549.1192020330030"
Return-Path: <share.kt@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16932
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: share.kt@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_54036_31414549.1192020330030
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi All,

WHile installing framebuffer driver for BCM chip in MIPS platform(cross
compiled in intel 86).
I am getting the following error.
Can somebody help in this regard?
Thanks in Advance.

# insmod brcmstfb.ko
brcmstfb: Unknown symbol unregister_framebuffer
brcmstfb: Unknown symbol printf
brcmstfb: Unknown symbol __make_dp
brcmstfb: Unknown symbol malloc
brcmstfb: Unknown symbol framebuffer_alloc
brcmstfb: Unknown symbol fb_find_mode
brcmstfb: Unknown symbol fb_dealloc_cmap
brcmstfb: Unknown symbol brcm_dir_entry
brcmstfb: Unknown symbol register_framebuffer
brcmstfb: Unknown symbol fb_alloc_cmap
brcmstfb: Unknown symbol framebuffer_release
brcmstfb: Unknown symbol free

-- 
Thanks & Regards,
kaka

------=_Part_54036_31414549.1192020330030
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Hi All,</div>
<div>&nbsp;</div>
<div>WHile installing framebuffer driver for BCM chip in MIPS platform(cross compiled in intel 86).</div>
<div>I am getting the following error.</div>
<div>Can somebody help in this regard?</div>
<div>Thanks in Advance.</div>
<div>&nbsp;</div>
<div># insmod brcmstfb.ko<br>brcmstfb: Unknown symbol unregister_framebuffer<br>brcmstfb: Unknown symbol printf<br>brcmstfb: Unknown symbol __make_dp<br>brcmstfb: Unknown symbol malloc<br>brcmstfb: Unknown symbol framebuffer_alloc 
<br>brcmstfb: Unknown symbol fb_find_mode<br>brcmstfb: Unknown symbol fb_dealloc_cmap<br>brcmstfb: Unknown symbol brcm_dir_entry<br>brcmstfb: Unknown symbol register_framebuffer<br>brcmstfb: Unknown symbol fb_alloc_cmap<br>
brcmstfb: Unknown symbol framebuffer_release<br>brcmstfb: Unknown symbol free<br><br>-- <br>Thanks &amp; Regards,<br>kaka </div>

------=_Part_54036_31414549.1192020330030--
