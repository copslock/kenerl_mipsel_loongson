Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Jan 2006 10:39:07 +0000 (GMT)
Received: from nproxy.gmail.com ([64.233.182.194]:5982 "EHLO nproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133370AbWAFKit convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 6 Jan 2006 10:38:49 +0000
Received: by nproxy.gmail.com with SMTP id k27so7427nfc
        for <linux-mips@linux-mips.org>; Fri, 06 Jan 2006 02:41:31 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=H+zeV1IM68ru1z0EnFJ1P574MPc/WNHRLz+aqvXZHWat1Hi7BaoRTFtRUQE6XMPgLRS60eb89FTbBU/8Wh41mAZee83c2PVcrouBjpERjvfdpGAULdpAZTUDSv5dfTWaLJQS59qUc6E2XfvTxX970j9ogVfTgC1/gvTBuDpznbw=
Received: by 10.48.249.2 with SMTP id w2mr651197nfh;
        Fri, 06 Jan 2006 02:41:30 -0800 (PST)
Received: by 10.48.225.20 with HTTP; Fri, 6 Jan 2006 02:41:30 -0800 (PST)
Message-ID: <c58a7a270601060241u765acb76s61bb30d443c420f1@mail.gmail.com>
Date:	Fri, 6 Jan 2006 10:41:30 +0000
From:	Alex Gonzalez <langabe@gmail.com>
To:	linux-mips@linux-mips.org
Subject: Jump/branch to external symbol
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Return-Path: <langabe@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9785
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: langabe@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

I am having GNU gas related problems when compiling assembler files
which contain jumps to external symbols, for example when jumping from
an assembler to a C function.

Using binutils-2.15 GAS will produce a "Cannot branch to undefined
symbol" error. Applying the patch at
http://sources.redhat.com/ml/binutils/2004-04/msg00476.html, which
creates an "allow_branch_to_undefined" option I am able to succesfully
compile an executable. I am happy with this as I only need to apply
the option to the problematic files and it does not change the
behaviour of gas in general.

Now, my crosscompiler toolchain is based on binutils-2.13. When I try
to apply the same patch to it, I get a different error, "Can not
represent BFD_RELOC_16_PCREL_S2 relocation in this object file
format".

There are various posts around referring to this problems. As a
consequence I have read different opinions, solutions that apply to
specific version or binutils, solutions more or less accepted by
everyone, and as usual I am very confused.

If I compile with "-mno-abicalls -fno-pic" gas reports no errors
(which I believe is what the Linux kernel does), but I need to link
with some pic libraries which use glibc, so this is not a valid
solution for me.

I am happy with the patch for binutils-2.15, and I would need a
solution for binutils-2.13.

Can anybody offer any help?

Thanks,
Alex
