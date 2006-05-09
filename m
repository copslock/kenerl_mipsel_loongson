Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 May 2006 02:03:11 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.189]:53115 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S8133850AbWEIBDB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 9 May 2006 02:03:01 +0100
Received: by nf-out-0910.google.com with SMTP id m19so320909nfc
        for <linux-mips@linux-mips.org>; Mon, 08 May 2006 18:03:00 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ueBnC8QhjO9LVR3ZWzbcdM070WWydhKUlncFjNF54wGY4EOeHQ+EefA2RuN32MhwFRWZmtkcD7fMjRzxnCkU5LK9qv8XiwB6H2hI5nexlE6+aHSc0/aYQD0lZlTXNouc0vTEc4Kx8BoIR1bVwMHwMTLnDP2raGOBKhHGHrMWmK0=
Received: by 10.49.39.19 with SMTP id r19mr1651864nfj;
        Mon, 08 May 2006 18:03:00 -0700 (PDT)
Received: by 10.48.144.2 with HTTP; Mon, 8 May 2006 18:03:00 -0700 (PDT)
Message-ID: <50c9a2250605081803l3ac0465ase56bab689d1b34e8@mail.gmail.com>
Date:	Tue, 9 May 2006 09:03:00 +0800
From:	zhuzhenhua <zzh.hust@gmail.com>
To:	linux-mips <linux-mips@linux-mips.org>
Subject: how to reuse the initrd ram by busybox?
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Return-Path: <zzh.hust@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11363
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zzh.hust@gmail.com
Precedence: bulk
X-list: linux-mips

now i use a initrd to boot my system, then switch to the real root
filesystem, and i want to reuse the initrd.
i see in the redhat, it use the blockdev --flushbufs /dev/ram0 to
flush the initrd ram.
 and i can't find blockdev in busybox, so i use the freeramdisk
/dev/ram0, but it seems has no effect.is there any other command to
finish this job?

thanks for any hints

Best regards

zhuzhenhua
