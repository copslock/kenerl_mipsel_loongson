Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Oct 2007 09:15:42 +0000 (GMT)
Received: from ug-out-1314.google.com ([66.249.92.169]:64490 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20023768AbXJ3JPd (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 30 Oct 2007 09:15:33 +0000
Received: by ug-out-1314.google.com with SMTP id u2so68853uge
        for <linux-mips@linux-mips.org>; Tue, 30 Oct 2007 02:15:16 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:references;
        bh=2jlNhPRsMrznjxvEokt0v9gs2zBq/CokBp09DMtDGgI=;
        b=bErPen/Pg8igGGAcq3CWAPQEwIk14KEvKg4hKNOp2NfkEVYobPHUohTdYnhXYmMXXr6yLz9JdoSRp+JUjyR8Fneds3rNCeV8I0ZwQHWH/KrCpw9BADybUu2KvSmx6E6WtUWb8xACBBFG3ztBEqIg9kr1XXneByfOviImvG2cfxc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:references;
        b=ceRa1/iNv+oibwuS2Pxm2XrT5a3SLYFtF0cPQrK8kggN1jS4neoVVdljStXrS+LCF79+RjMffVEqgX3O97ym9g++UzB/7anhABBtgqHtVrZGqtjiA7cj7kaM8pmxop2aUjWLVcDOtGxcLi1oJS6GnMeOYoXQeEKTsHbFPl7A4oc=
Received: by 10.67.115.17 with SMTP id s17mr599514ugm.1193735715941;
        Tue, 30 Oct 2007 02:15:15 -0700 (PDT)
Received: by 10.66.254.5 with HTTP; Tue, 30 Oct 2007 02:15:15 -0700 (PDT)
Message-ID: <eea8a9c90710300215l2fdd9bf6u2238f1f9d8f1d66e@mail.gmail.com>
Date:	Tue, 30 Oct 2007 14:45:15 +0530
From:	kaka <share.kt@gmail.com>
To:	linux-mips@linux-mips.org, uclinux-dev@uclinux.org,
	linux-fbdev-users@lists.sourceforge.net
Subject: Unknown Synbol:__gp_disp
In-Reply-To: <eea8a9c90710300200wb39c64fuc0c6718bd7aeec48@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_989_5231145.1193735715939"
References: <eea8a9c90710300200wb39c64fuc0c6718bd7aeec48@mail.gmail.com>
Return-Path: <share.kt@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17308
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: share.kt@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_989_5231145.1193735715939
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi All,

While installing the driver by insmod cmd. i am getting the above error,
Unknown Synbol:__gp_disp,
I have added ``-fno-pic -mno-abicalls'' option in the make file as


$(BCM_OBJ_DIR)/%.o: %.c

@echo '$(CC) -c $(notdir $<)'

@$(CC) -fno-pic -mno-abicalls -MMD -c $(CFLAGS) $< -o $@



I tried by adding those symbols in the CFLAGS

CFLAGS += -fno-pic -mno-abicalls.

But it didn't help my cause.

Could anybody plz look in to the error and reply?

Thanks in advance


-- 
Thanks & Regards,
kaka

------=_Part_989_5231145.1193735715939
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Hi All,</div>
<div>&nbsp;</div>
<div>While installing the driver by insmod cmd. i am getting the above error, Unknown Synbol:__gp_disp,</div>
<div>I have added ``-fno-pic -mno-abicalls&#39;&#39; option in the make file as </div>
<div>&nbsp;</div>
<div><font size="2">
<p>$(BCM_OBJ_DIR)/%.o: %.c</p>
<p>@echo &#39;$(CC) -c $(notdir $&lt;)&#39;</p>
<p>@$(CC) -fno-pic -mno-abicalls -MMD -c $(CFLAGS) $&lt; -o $@</p>
<p>&nbsp;</p>
<p>I tried by adding those symbols in the CFLAGS</p><font size="2">
<p>CFLAGS +=&nbsp;-fno-pic -mno-abicalls.</p>
<p>But it didn&#39;t help my cause.</p>
<p>Could anybody plz look in to the error and reply?</p>
<p>Thanks in advance</p></font></font><br clear="all"><br>-- <br>Thanks &amp; Regards,<br>kaka </div><br clear="all"><br>

------=_Part_989_5231145.1193735715939--
