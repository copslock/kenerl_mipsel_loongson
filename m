Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 07 Jan 2007 10:57:08 +0000 (GMT)
Received: from ug-out-1314.google.com ([66.249.92.174]:20285 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20041940AbXAGK5D (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 7 Jan 2007 10:57:03 +0000
Received: by ug-out-1314.google.com with SMTP id 40so7038577uga
        for <linux-mips@linux-mips.org>; Sun, 07 Jan 2007 02:57:03 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=cN/D9KjWll59kasE3oStCudmunkJyKzyDvUDYpKvZrTZBWFNTlLgS9cjIPdlmbLxJdDYlHwgSfQkqDMbFLpORBiI7y61gx9MahMbb6lOvV53aFhcCoynp8JzwGaEHSD6y+OYUrNOLEdmMwzB5UN5rJmrAu4eZvcHT3xuCJ+NBUw=
Received: by 10.78.201.15 with SMTP id y15mr3716427huf.1168167422899;
        Sun, 07 Jan 2007 02:57:02 -0800 (PST)
Received: by 10.78.43.2 with HTTP; Sun, 7 Jan 2007 02:57:02 -0800 (PST)
Message-ID: <c4357ccd0701070257u73994becy81976a64e2eadabb@mail.gmail.com>
Date:	Sun, 7 Jan 2007 12:57:02 +0200
From:	"Alexander Sirotkin" <demiourgos@gmail.com>
To:	linux-mips@linux-mips.org
Subject: network hardware accelerators
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Return-Path: <demiourgos@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13547
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: demiourgos@gmail.com
Precedence: bulk
X-list: linux-mips

Hello.

I'd like to know LinuxMIPS community opinion on network hardware
accelerators. I'm not talking about VPN accelerators, there is plenty
of material on the subject on the net and the benefits are quite
clear, as well as potential problems.

There is a claim that in order to do wire-speed, i.e. 100Mbps, router
using not high-end embedded processor, say MIPS 4K or 24K, one has to
use hardware accelerators for firewall, NAT, bridging and other
standard networking features of the residential gateway. I know that
the idea of HW network accelerators is not very welcome in Linux
community and the problems in functionality that it can cause. But the
question still remains - whether 100Mbps firewall, NAT, etc can run on
moderately priced embedded processor without HW acceleration.

Opinions ?

I'm going to get my hands on a reference design board in order to do
some benchmarking, but maybe somebody saw these kinds of benchmarks on
the net ? There are quite a few processors we are looking at and it
would be problematic to benchmark them all.

Thanks.
