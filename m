Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Oct 2005 10:34:26 +0100 (BST)
Received: from wproxy.gmail.com ([64.233.184.199]:57963 "EHLO wproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133443AbVJZJeH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 26 Oct 2005 10:34:07 +0100
Received: by wproxy.gmail.com with SMTP id i6so47293wra
        for <linux-mips@linux-mips.org>; Wed, 26 Oct 2005 02:34:07 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=sNMv9SKtXvh1M1sQcN1+Fyj2sSjpvMk0gtpgiWzSEcOuVNfTiFFW1UUVqmyGt/zTnGhoS3Wf0d24NSHAxX9KZupGeVgwfCXjc2zvwcbahF/+bSWQc8aBeVtCOWDN6QbJCdZChpCBXRRCEcxnsrsC911aM2MiBxd1A4RJ6XljFRk=
Received: by 10.54.128.2 with SMTP id a2mr289298wrd;
        Wed, 26 Oct 2005 02:34:07 -0700 (PDT)
Received: by 10.54.133.2 with HTTP; Wed, 26 Oct 2005 02:34:07 -0700 (PDT)
Message-ID: <f69849430510260234p7370d51ahdbf6b80603fc7066@mail.gmail.com>
Date:	Wed, 26 Oct 2005 02:34:07 -0700
From:	kernel coder <lhrkernelcoder@gmail.com>
To:	linux-mips@linux-mips.org
Subject: Porting oprofile to 2.4.32 kernel
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Return-Path: <lhrkernelcoder@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9358
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lhrkernelcoder@gmail.com
Precedence: bulk
X-list: linux-mips

hi,
   i'm trying to port oprofile on 2.4.32 kernel running on MIPS
board.From where can i  get the patch for other boards so that i can
make a head start by using that patch as a guide.

lhrkernelcoder
