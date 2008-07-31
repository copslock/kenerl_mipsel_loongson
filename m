Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Jul 2008 07:41:32 +0100 (BST)
Received: from ti-out-0910.google.com ([209.85.142.186]:60751 "EHLO
	ti-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20027165AbYGaGlX (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 31 Jul 2008 07:41:23 +0100
Received: by ti-out-0910.google.com with SMTP id i7so103547tid.20
        for <linux-mips@linux-mips.org>; Wed, 30 Jul 2008 23:41:06 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=/quVvWTXxzPh/ctO58PQ+yI3CdD5vspqjyztzMbXYY8=;
        b=JxCSBzZdW1D14CkWQ6Fq8tYCf3NXuj7m0/bNPZBeQ5rXvA4K/y1UHmNnyf+lLBWIuS
         iEeGxfTi8csMYYYL06jTw2yP0ajsGBGgrbZL4OVc57K1c4JgjbJo4L6eOLDvi0z7Nb+7
         zNJ/fyAry5LOR79eJGpdxNHVc0r9RWqgGQyOw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=JvnqB9nF/09gx1Rc3tQnFXpzFKqR74ngXmOKj+FBr/MFT6X/W/prEkP2jyv95PBMxu
         P6Hhn4i5x7jU52Bo9cbddpWMJNUfyta3hqMNnD5LcntR9GouS9qSVgExcRHKyOdBvapn
         /bV3Sq/Bfe3OzJI7qZSZ4zhPAnnnkAXKOzm3w=
Received: by 10.110.37.17 with SMTP id k17mr8391088tik.13.1217486466097;
        Wed, 30 Jul 2008 23:41:06 -0700 (PDT)
Received: by 10.110.103.6 with HTTP; Wed, 30 Jul 2008 23:41:06 -0700 (PDT)
Message-ID: <3f696b20807302341n39d53172q39adf8e10c6249bb@mail.gmail.com>
Date:	Thu, 31 Jul 2008 14:41:06 +0800
From:	"Chung-Chi Lo" <linolo@gmail.com>
To:	linux-mips@linux-mips.org
Subject: Config7.WII and IPI mechanism in SMTC linux
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Return-Path: <linolo@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20061
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linolo@gmail.com
Precedence: bulk
X-list: linux-mips

Hello,

My platform is MIPS 34K cpu core and Config7.WII=1.

If Config7.WII=1 and a TC is idle, the TC will execute "wait"
instruction with TCSTATUS.IXMT=1
to disable interrupt.

But in 34K, interrupts are not TC-specific. So some TCs will not get
real interrupts to break "wait"
instruction. Even in SMTC's IPI mechanism, the IPI mechanism is to
program TCRestart if target
TC is in the same VPE.

In function smtc_send_ipi, it detects if TC's interrupt is disabled,
then enqueue IPI message to
target TC's queue. So some TCs are always idle and cannot break "wait"
instruction. I don't know
if I miss something and please comment on this problem. Thanks.

                if ((tcstatus & TCSTATUS_IXMT) != 0) {
                        /*
                         * Spin-waiting here can deadlock,
                         * so we queue the message for the target TC.
                         */
                        write_tc_c0_tchalt(0);
                        UNLOCK_CORE_PRA();
                        .....
                        smtc_ipi_nq(&IPIQ[cpu], pipi);
                }

--
Lino, Chung-Chi Lo
