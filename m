Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Jun 2008 11:03:28 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:14056 "EHLO
	ti-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20021862AbYFEKDZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 5 Jun 2008 11:03:25 +0100
Received: by ti-out-0910.google.com with SMTP id i7so152191tid.20
        for <linux-mips@linux-mips.org>; Thu, 05 Jun 2008 03:02:42 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=YVVvVbAjpysHLwtKLqpRAYDXH17e/Z/OchQz59UNc0Y=;
        b=JYhLPQX1sVbxKHM/FVHoidj3r6vYn6GSb/BKeD/XZ+68zozxBQtBT6c6VE/h/QN2LQ
         g/IEw8LeSrsUlIuxZo3AKrzpUoPO1pYq2c6DOOADpFq2CNm/9Q+CUdERaNo8XK9Wut2p
         zfLwaUCDN7kscSsLnpQkVEhY+NO1zILGLB8Po=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=u/g7LmSRHc0ZGThd0MA4Cnd1YLn0dFrYlGSpOZxPmy9GkbXNJ/K7+HSkGXKb19yR7l
         qWzh0pU5vXkCKY1F6ghJ2Z+RgCVCiMMsfpRKxx4EdvPIraIhGrhsdNpIYqTqI3gMzZdH
         KFPErGxm2tS8Ta+tTmhTToAc82D4TjNYk/cFk=
Received: by 10.110.15.9 with SMTP id 9mr333229tio.44.1212660162689;
        Thu, 05 Jun 2008 03:02:42 -0700 (PDT)
Received: by 10.110.11.2 with HTTP; Thu, 5 Jun 2008 03:02:42 -0700 (PDT)
Message-ID: <7f245da80806050302m6b449e6m1f84dc7ef7efff46@mail.gmail.com>
Date:	Thu, 5 Jun 2008 15:32:42 +0530
From:	"Chetan Nanda" <chetannanda@gmail.com>
To:	linux-mips@linux-mips.org
Subject: understanding head.S
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Return-Path: <chetannanda@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19401
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chetannanda@gmail.com
Precedence: bulk
X-list: linux-mips

Hi All,
I was reading the boot code for MIPS.
in head.S file before jumping to 'start_kernel' it calculate the stack
pointer address as follow:

"
	PTR_LA		$28, init_thread_union
	PTR_ADDIU	sp, $28, _THREAD_SIZE - 32
	set_saved_sp	sp, t0, t1
	PTR_SUBU	sp, 4 * SZREG		# init stack pointer
"

Can anyone please explains me this 4 lines of code?
Why ' _THREAD_SIZE - 32' is added in 'sp' ?
What 'set_saved_sp' will do ?
and then why we subtract '4 * SZREG' from 'sp' ?

Please hep me to understand this code better.

Thanks,
Chetan Nanda
