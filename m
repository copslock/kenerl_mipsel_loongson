Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Sep 2007 14:23:13 +0100 (BST)
Received: from wa-out-1112.google.com ([209.85.146.178]:36290 "EHLO
	wa-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20022402AbXICNXE (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 3 Sep 2007 14:23:04 +0100
Received: by wa-out-1112.google.com with SMTP id m16so1815203waf
        for <linux-mips@linux-mips.org>; Mon, 03 Sep 2007 06:22:53 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=QuaR5PY/i0/FeZr54S54jXRb554tyIWn3F+M+GrZ7EbO3PjwhdQEv/zLpJcwsoW+Tx4cc9QJuArMWvy56vAiw+/IoFjlExcODP0pSdepbL2xxn1gU6Hej2rBBdyCZQtAhM8+HuuXKOFxBMabJwraFiygYgaZ92dvaCKfVB2L7ME=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=iWMF7PYKlxQa2zHT3oAgPLQ7AFKLE4xSIs1PmNh7l0ovjyOOcxZFlNZaOkjSu0FvH2zeJbn1lTXhFvdDkgVx3cFn5UW2tTHVU+MId9GtL/1vej0sazSaBZkGHFY9OLJDIs2JofhE9nyVX8xq0FtUnoMvtM9VgSkdRo3KiFyZMng=
Received: by 10.114.157.1 with SMTP id f1mr3769107wae.1188825772707;
        Mon, 03 Sep 2007 06:22:52 -0700 (PDT)
Received: by 10.115.111.13 with HTTP; Mon, 3 Sep 2007 06:22:51 -0700 (PDT)
Message-ID: <40101cc30709030622i6fc970e9h20010069aa660752@mail.gmail.com>
Date:	Mon, 3 Sep 2007 15:22:51 +0200
From:	"Matteo Croce" <technoboy85@gmail.com>
To:	linux-mips@linux-mips.org
Subject: [PATCH 0/7] AR7: second round
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Return-Path: <technoboy85@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16348
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: technoboy85@gmail.com
Precedence: bulk
X-list: linux-mips

I have followed Florian's instructions, and that are the patches for
AR7 against a linux-mips git tree
I have also included all the drivers since now all the patch are separate
