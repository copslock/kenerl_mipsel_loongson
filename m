Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Feb 2005 22:26:53 +0000 (GMT)
Received: from rproxy.gmail.com ([IPv6:::ffff:64.233.170.197]:833 "EHLO
	rproxy.gmail.com") by linux-mips.org with ESMTP id <S8224933AbVBCW0h>;
	Thu, 3 Feb 2005 22:26:37 +0000
Received: by rproxy.gmail.com with SMTP id 1so281451rny
        for <linux-mips@linux-mips.org>; Thu, 03 Feb 2005 14:26:34 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=kGm4iJEh/FdRE2vedsT4LHCchyZwPU5VXWgcSrXqnhsry0YxIoehqU1PvjFcisPRgobeqOBGMiR9eAT5R4LXN/RAdsMBvCD+XRJADGhexjcoEbLasF0BDX81t58WmnxvDwwFUHW+6AGB0TmBMCapau8V6mjwkZ1THpV/cfGom7k=
Received: by 10.38.206.45 with SMTP id d45mr29311rng;
        Thu, 03 Feb 2005 14:26:34 -0800 (PST)
Received: by 10.38.179.2 with HTTP; Thu, 3 Feb 2005 14:26:34 -0800 (PST)
Message-ID: <52dd17640502031426660c7196@mail.gmail.com>
Date:	Thu, 3 Feb 2005 16:26:34 -0600
From:	Guy Streeter <guy.streeter@gmail.com>
Reply-To: Guy Streeter <guy.streeter@gmail.com>
To:	linux-mips <linux-mips@linux-mips.org>
Subject: NR_IRQS and possible irq values on malta
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <guy.streeter@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7138
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: guy.streeter@gmail.com
Precedence: bulk
X-list: linux-mips

In mips_pcibios_iack() the irq number is obtained like this:

		irq = GT_READ(GT_PCI0_IACK_OFS);
		irq &= 0xff;

(for coreLV, but similarly for others). This value is used to index
into an array of size NR_IRQS, which is set in mach-generic/irq.h to
128.
 I realize that when things work right, the value of irq isn't likely
to get that big, but it seems to me it should be masked down to 127 or
the NR_IRQS value should be larger. I have no opinion which is the
right thing to do.

--Guy
