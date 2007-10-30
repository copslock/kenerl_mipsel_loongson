Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Oct 2007 09:01:11 +0000 (GMT)
Received: from ug-out-1314.google.com ([66.249.92.168]:50850 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20023718AbXJ3JBB (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 30 Oct 2007 09:01:01 +0000
Received: by ug-out-1314.google.com with SMTP id u2so67169uge
        for <linux-mips@linux-mips.org>; Tue, 30 Oct 2007 02:00:44 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type;
        bh=JLrCEKDncnVH+d88xDeEImUi3jVB02nRqLwHpQq3FyY=;
        b=EyXpFapHj6Memupj6QEqIUjPLgEf5jBudqKyC3eDa98qudaKa+SvlDbcqDxZnYibNnIxkPWeymAWf7JeMrXu7ciCtwkWEsiuASb7S1w7uECuu1ZzkFhDFodPGdVjdMtDFyDqqxqjkymtOg/9A8rcWQ2jBbkQb+E833J7UT0JFYM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=UabBZNfaGQ7FfBhqjnTGnbmHaZvly5qXHhApQ7b3BBk07Q3lRYCY1jY402tNGCT3g1g/013eWq91MxVuJjwMj7OvqFtusvZzhue5RKpgK0v7hGvjhxWyyzEvWKvHlA2bvtlTms0OKWcPc6Ss6YwxSwUBx6XaQhuy+EjFjuSnG/k=
Received: by 10.67.29.12 with SMTP id g12mr611827ugj.1193734843972;
        Tue, 30 Oct 2007 02:00:43 -0700 (PDT)
Received: by 10.66.254.5 with HTTP; Tue, 30 Oct 2007 02:00:43 -0700 (PDT)
Message-ID: <eea8a9c90710300200wb39c64fuc0c6718bd7aeec48@mail.gmail.com>
Date:	Tue, 30 Oct 2007 14:30:43 +0530
From:	kaka <share.kt@gmail.com>
To:	linux-mips@linux-mips.org, uclinux-dev@uclinux.org,
	linux-fbdev-users@lists.sourceforge.net
Subject: Unknown Synbol:__gp_disp
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_964_27889863.1193734843975"
Return-Path: <share.kt@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17305
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: share.kt@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_964_27889863.1193734843975
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

------=_Part_964_27889863.1193734843975
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
<p>Thanks in advance</p></font></font><br clear="all"><br>-- <br>Thanks &amp; Regards,<br>kaka </div>

------=_Part_964_27889863.1193734843975--
