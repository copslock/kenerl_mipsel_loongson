Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Oct 2007 07:45:14 +0100 (BST)
Received: from py-out-1112.google.com ([64.233.166.180]:60252 "EHLO
	py-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20022897AbXJIGpF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 9 Oct 2007 07:45:05 +0100
Received: by py-out-1112.google.com with SMTP id p76so2928916pyb
        for <linux-mips@linux-mips.org>; Mon, 08 Oct 2007 23:44:46 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:references;
        bh=kICjZkZ3KAaVvHDEruu88ErmE3XFJKxAHiGh86F6MNQ=;
        b=lm/4CpbEx7Awq8xvr8ReY+EQ4SPau3eNN6SiIOumK0HVPcucrexoepnoLSLhM5LiZYnY9v/4Ewm5jZrTxkxtQr2mjgO1mOTEvXlC/esCGppFjtnFHNkAW1lUqUkeLjWcWOmSrKecv4YpkEIKumAYRiVwMLReudGm4A0fSXLaJe8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:references;
        b=GmkCQbhvpHgrq8Ds+g+zpfbsbjB7/ADXNYtpKwss7TVPeoCZzQG1QuxPQqCmwoZc4nsINEqZcm0wLbVF+Pu6taXtrKzb/Xi2f0RE6zKAPH8+smwg9Aths1/KKKKM4OEMZX3xlvPY5Pg8sEvGBI5WwGjB5SYuoL/EpOJyjBGVuC8=
Received: by 10.35.131.13 with SMTP id i13mr19413948pyn.1191912286773;
        Mon, 08 Oct 2007 23:44:46 -0700 (PDT)
Received: by 10.35.39.19 with HTTP; Mon, 8 Oct 2007 23:44:46 -0700 (PDT)
Message-ID: <eea8a9c90710082344r1beebc2bh507a0ba741efd364@mail.gmail.com>
Date:	Tue, 9 Oct 2007 12:14:46 +0530
From:	kaka <share.kt@gmail.com>
To:	linux-mips@linux-mips.org, linux-git@linux-mips.org
Subject: Fwd: Error opening framebuffer device
In-Reply-To: <eea8a9c90710082258y5bbfc987h83f00d2b48d96fc6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_47923_13726289.1191912286764"
References: <eea8a9c90710082258y5bbfc987h83f00d2b48d96fc6@mail.gmail.com>
Return-Path: <share.kt@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16896
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: share.kt@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_47923_13726289.1191912286764
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

*Hi All,*

*While running  the cross compiled directFB example on MIPS chip,*

*
We tried to install the framebuffer driver(command given below) and we
have already created the node fb0.*

*We are getting the following error, *

*Can anybody throw some light on it?*

*Thanks in Advance.*

*While running the following command in MIPS chip, we are getting the
following error.*

# insmod brcmstfb.ko
brcmstfb: Unknown symbol unregister_framebuffer
brcmstfb: Unknown symbol BKNI_EnterCriticalSection_tagged
brcmstfb: Unknown symbol printf
brcmstfb: Unknown symbol BKNI_DestroyEventGroup
brcmstfb: Unknown symbol BKNI_WaitForEvent_tagged
brcmstfb: Unknown symbol BKNI_Printf
brcmstfb: Unknown symbol __divsf3
brcmstfb: Unknown symbol BKNI_Vprintf
brcmstfb: Unknown symbol BKNI_Memset
brcmstfb: Unknown symbol bnetif_dma_data
brcmstfb: Unknown symbol bnetif_dma_delete_filter
brcmstfb: Unknown symbol cleanup_bnetif_dma
brcmstfb: Unknown symbol BKNI_AcquireMutex_tagged
brcmstfb: Unknown symbol malloc
brcmstfb: Unknown symbol BKNI_DestroyMutex
brcmstfb: Unknown symbol framebuffer_alloc
brcmstfb: Unknown symbol BKNI_RemoveEventGroup
brcmstfb: Unknown symbol BKNI_Malloc_tagged
brcmstfb: Unknown symbol BKNI_CreateEventGroup
brcmstfb: Unknown symbol BKNI_WaitForGroup
brcmstfb: Unknown symbol __extendsfdf2
brcmstfb: Unknown symbol BKNI_SetEvent_tagged
brcmstfb: Unknown symbol BKNI_Memcpy
brcmstfb: Unknown symbol BKNI_LinuxKernel_SetIsrTasklet
brcmstfb: Unknown symbol BKNI_Memcmp
brcmstfb: Unknown symbol fb_find_mode
brcmstfb: Unknown symbol fb_dealloc_cmap
brcmstfb: Unknown symbol bnetif_dma_stop
brcmstfb: Unknown symbol BKNI_ResetEvent_tagged
brcmstfb: Unknown symbol BKNI_CreateMutex
brcmstfb: Unknown symbol BKNI_CreateEvent_tagged
brcmstfb: Unknown symbol __floatsisf
brcmstfb: Unknown symbol brcm_dir_entry
brcmstfb: Unknown symbol register_framebuffer
brcmstfb: Unknown symbol BKNI_Fail
brcmstfb: Unknown symbol fb_alloc_cmap
brcmstfb: Unknown symbol BKNI_Snprintf
brcmstfb: Unknown symbol BKNI_Delay_tagged
brcmstfb: Unknown symbol BKNI_LeaveCriticalSection_tagged
brcmstfb: Unknown symbol BKNI_Sleep_tagged
brcmstfb: Unknown symbol bnetif_dma_add_filter
brcmstfb: Unknown symbol BKNI_Free_tagged
brcmstfb: Unknown symbol BKNI_DestroyEvent_tagged
brcmstfb: Unknown symbol init_bnetif_dma
brcmstfb: Unknown symbol framebuffer_release
brcmstfb: Unknown symbol BKNI_AddEventGroup
brcmstfb: Unknown symbol BKNI_ReleaseMutex_tagged
brcmstfb: Unknown symbol __addsf3
brcmstfb: Unknown symbol free
insmod: cannot insert `brcmstfb.ko': Unknown symbol in module (2): No
such file or directory
#

# ../../cross_directfb/simple_mips

     =======================|  DirectFB 1.0.0  |=======================
          (c) 2001-2007  The DirectFB Organization (directfb.org)
          (c) 2000-2004  Convergence (integrated media) GmbH
        ------------------------------------------------------------

(*) DirectFB/Core: Single Application Core. (2007-10-05 14:17)
(!) Direct/Util: opening '/dev/fb0' failed
    --> No such device or address
(!) DirectFB/FBDev: Error opening framebuffer device!
(!) DirectFB/FBDev: Use 'fbdev' option or set FRAMEBUFFER environment variable.
(!) DirectFB/Core: Could not initialize 'system' core!
    --> Initialization error!simple.c <96>:
        (#) DirectFBError [DirectFBCreate (&dfb)]: Initialization error!
#

#

------=_Part_47923_13726289.1191912286764
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<span class="gmail_quote"><br></span>
<div><pre><strong><font color="#000099">Hi All,</font></strong></pre><pre><strong><font color="#000099">While running  the cross compiled directFB example on MIPS chip,</font></strong></pre><pre><strong><font color="#000099">

We tried to install the framebuffer driver(command given below) and we have already created the node fb0.</font></strong></pre><pre><strong><font color="#000099">We are getting the following error, </font></strong>
</pre><pre><strong><font color="#000099">Can anybody throw some light on it?</font></strong></pre><pre><strong><font color="#000099">Thanks in Advance.</font></strong></pre><pre><pre><strong><font color="#000099">While running the following command in MIPS chip, we are getting the following error.
</font></strong></pre><pre># insmod brcmstfb.ko
brcmstfb: Unknown symbol unregister_framebuffer
brcmstfb: Unknown symbol BKNI_EnterCriticalSection_tagged
brcmstfb: Unknown symbol printf
brcmstfb: Unknown symbol BKNI_DestroyEventGroup
brcmstfb: Unknown symbol BKNI_WaitForEvent_tagged
brcmstfb: Unknown symbol BKNI_Printf
brcmstfb: Unknown symbol __divsf3
brcmstfb: Unknown symbol BKNI_Vprintf
brcmstfb: Unknown symbol BKNI_Memset
brcmstfb: Unknown symbol bnetif_dma_data
brcmstfb: Unknown symbol bnetif_dma_delete_filter
brcmstfb: Unknown symbol cleanup_bnetif_dma
brcmstfb: Unknown symbol BKNI_AcquireMutex_tagged
brcmstfb: Unknown symbol malloc
brcmstfb: Unknown symbol BKNI_DestroyMutex
brcmstfb: Unknown symbol framebuffer_alloc
brcmstfb: Unknown symbol BKNI_RemoveEventGroup
brcmstfb: Unknown symbol BKNI_Malloc_tagged
brcmstfb: Unknown symbol BKNI_CreateEventGroup
brcmstfb: Unknown symbol BKNI_WaitForGroup
brcmstfb: Unknown symbol __extendsfdf2
brcmstfb: Unknown symbol BKNI_SetEvent_tagged
brcmstfb: Unknown symbol BKNI_Memcpy
brcmstfb: Unknown symbol BKNI_LinuxKernel_SetIsrTasklet
brcmstfb: Unknown symbol BKNI_Memcmp
brcmstfb: Unknown symbol fb_find_mode
brcmstfb: Unknown symbol fb_dealloc_cmap
brcmstfb: Unknown symbol bnetif_dma_stop
brcmstfb: Unknown symbol BKNI_ResetEvent_tagged
brcmstfb: Unknown symbol BKNI_CreateMutex
brcmstfb: Unknown symbol BKNI_CreateEvent_tagged
brcmstfb: Unknown symbol __floatsisf
brcmstfb: Unknown symbol brcm_dir_entry
brcmstfb: Unknown symbol register_framebuffer
brcmstfb: Unknown symbol BKNI_Fail
brcmstfb: Unknown symbol fb_alloc_cmap
brcmstfb: Unknown symbol BKNI_Snprintf
brcmstfb: Unknown symbol BKNI_Delay_tagged
brcmstfb: Unknown symbol BKNI_LeaveCriticalSection_tagged
brcmstfb: Unknown symbol BKNI_Sleep_tagged
brcmstfb: Unknown symbol bnetif_dma_add_filter
brcmstfb: Unknown symbol BKNI_Free_tagged
brcmstfb: Unknown symbol BKNI_DestroyEvent_tagged
brcmstfb: Unknown symbol init_bnetif_dma
brcmstfb: Unknown symbol framebuffer_release
brcmstfb: Unknown symbol BKNI_AddEventGroup
brcmstfb: Unknown symbol BKNI_ReleaseMutex_tagged
brcmstfb: Unknown symbol __addsf3
brcmstfb: Unknown symbol free
insmod: cannot insert `brcmstfb.ko&#39;: Unknown symbol in module (2): No such file or directory
#
</pre></pre><pre># ../../cross_directfb/simple_mips
                                                                                                                             
     =======================|  DirectFB 1.0.0  |=======================
          (c) 2001-2007  The DirectFB Organization (<a onclick="return top.js.OpenExtLink(window,event,this)" href="http://directfb.org/" target="_blank">directfb.org</a>)
          (c) 2000-2004  Convergence (integrated media) GmbH
        ------------------------------------------------------------
                                                                                                                             
(*) DirectFB/Core: Single Application Core. (2007-10-05 14:17)
(!) Direct/Util: opening &#39;/dev/fb0&#39; failed
    --&gt; No such device or address
(!) DirectFB/FBDev: Error opening framebuffer device!
(!) DirectFB/FBDev: Use &#39;fbdev&#39; option or set FRAMEBUFFER environment variable.
(!) DirectFB/Core: Could not initialize &#39;system&#39; core!
    --&gt; Initialization error!
simple.c &lt;96&gt;:
        (#) DirectFBError [DirectFBCreate (&amp;dfb)]: Initialization error!
#
</pre><pre>#</pre><pre>&nbsp;</pre></div>

------=_Part_47923_13726289.1191912286764--
