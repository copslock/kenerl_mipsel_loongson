Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 03 Oct 2009 16:48:25 +0200 (CEST)
Received: from mail-bw0-f208.google.com ([209.85.218.208]:54327 "EHLO
	mail-bw0-f208.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492953AbZJCOsT (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 3 Oct 2009 16:48:19 +0200
Received: by bwz4 with SMTP id 4so1680563bwz.0
        for <multiple recipients>; Sat, 03 Oct 2009 07:48:12 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=FdRNNPhMP/PKLMtu5DWkknzvugHjsqs0w5ArCcHp/+w=;
        b=u+0u1/tl3cHzlL33aRJ2Qc5bs+k8No81E2Tcn/A5DW/ORopYbY1K+kici3IORrYqF7
         dAlF966b89q0+6CUOFZPsj63dSvfw9iZuIi09GnHYp7VbcWY3YP5eM0ArL3IK8lDTyFc
         oEgzT2oCl+QC6dojgEzVxWLaG6otElFQBrqhM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=g8wARAyEZ6THhMFSrm9QEOOcZB93QbVtaEXTiKiKF2P4qemClGbkFHaAjkIws49icp
         PpRXxeFdvjfSSh38ynmsB/lf3E6R1LmdX9j6e+X9Hp/CW3ToyDbbzERVQXdovMcDh0PX
         2fhqYuKrUs0Qc382b1gzl96g0QLOI0AIBcS/s=
MIME-Version: 1.0
Received: by 10.102.226.17 with SMTP id y17mr918559mug.67.1254581292384; Sat, 
	03 Oct 2009 07:48:12 -0700 (PDT)
Date:	Sat, 3 Oct 2009 16:48:12 +0200
Message-ID: <f861ec6f0910030748l396b45bck858f15460354e58e@mail.gmail.com>
Subject: Reason for PIO_MASK?
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Linux-MIPS <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24135
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

In arch/mips/lib/iomap.c  there's this "#define PIO_MASK 0x0ffff"
which limits the ability to successfully call ioport_map() to the
first 64kB.  This causes pata_pcmcia to error out on CF card
probe because devm_ioport_map() is called with the remapped
PCMCIA IO area, which is somewhere in MAP_BASE space.

I've temporarily removed the PIO_MASK check and pata_pcmcia
works as expected. Is there any way around this, other than
creating an Alchemy-specific ioport_map() function?

Thanks,
        Manuel Lauss
