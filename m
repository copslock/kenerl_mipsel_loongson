Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Feb 2005 17:42:46 +0000 (GMT)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:40018
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225200AbVBERmb>; Sat, 5 Feb 2005 17:42:31 +0000
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1CxTx1-0003ar-00
	for <linux-mips@linux-mips.org>; Sat, 05 Feb 2005 18:42:31 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1CxTwM-0008K1-00; Sat, 05 Feb 2005 18:41:50 +0100
Date:	Sat, 5 Feb 2005 18:41:50 +0100
To:	Robert Michel <news@robertmichel.de>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: patch like kexec for MIPS possible?
Message-ID: <20050205174150.GU28252@rembrandt.csv.ica.uni-stuttgart.de>
References: <20050205165019.GC3071@mail.robertmichel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050205165019.GC3071@mail.robertmichel.de>
User-Agent: Mutt/1.5.6+20040907i
From:	Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7161
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Robert Michel wrote:
> Salve!
> 
> Does the MIPS CPUs makes a patch like kexec possible?
> 
> Kexec is a kernel patch which allows you to start another kernel.

MIPS kernels are usually position dependent code, and loaded in
unmapped memory, so a kernel would need to overwrite itself for
kexec. I don't know if kexec is flexible enough to handle this.

> IMHO would such a kernel patch would be handy, especialy for
> small MIPS Linux boxes. For more info about kexec read e.g.
> http://www-106.ibm.com/developerworks/linux/library/l-kexec.html

Frankly, I don't see what kexec is good for. Who else besides
kernel developers would need to reboot a machine continuously?


Thiemo
