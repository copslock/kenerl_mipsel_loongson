Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Jan 2003 06:05:59 +0000 (GMT)
Received: from natsmtp01.webmailer.de ([IPv6:::ffff:192.67.198.81]:45762 "EHLO
	post.webmailer.de") by linux-mips.org with ESMTP
	id <S8225248AbTAQGF6>; Fri, 17 Jan 2003 06:05:58 +0000
Received: from excalibur.cologne.de (p5085126C.dip.t-dialin.net [80.133.18.108])
	by post.webmailer.de (8.9.3/8.8.7) with ESMTP id HAA05638
	for <linux-mips@linux-mips.org>; Fri, 17 Jan 2003 07:05:48 +0100 (MET)
Received: from karsten by excalibur.cologne.de with local (Exim 3.35 #1 (Debian))
	id 18ZPiL-0000M7-00
	for <linux-mips@linux-mips.org>; Fri, 17 Jan 2003 07:10:49 +0100
Date: Fri, 17 Jan 2003 07:10:48 +0100
From: Karsten Merker <karsten@excalibur.cologne.de>
To: linux-mips@linux-mips.org
Subject: Re: Problems booting
Message-ID: <20030117061047.GA474@excalibur.cologne.de>
Mail-Followup-To: Karsten Merker <karsten@excalibur.cologne.de>,
	linux-mips@linux-mips.org
References: <1042769475.2735.161.camel@Opus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1042769475.2735.161.camel@Opus>
User-Agent: Mutt/1.3.28i
X-No-Archive: yes
Return-Path: <karsten@excalibur.cologne.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1175
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: karsten@excalibur.cologne.de
Precedence: bulk
X-list: linux-mips

On Thu, Jan 16, 2003 at 09:11:14PM -0500, Justin Pauley wrote:

> Well, MOPD works now! And I installed debian linux. However, now when i
> try to boot with:
> boot 3/rz0/vmlinux console=ttyS0 
> I get the following:
> delo V0.7 Copyright....
> extfs_open returned Unknown ext2 error(2133571404)
> Couldnt fetch config.file /etc/delo.cconf

Try just booting with "boot 3/rz0" without further parameters. Delo takes
its parameters a bit differently than e.g. Ultrixboot and if given no
parameters, it should use the default values from the installation process.
If this does not help: do you have /boot and /etc on the same partition? If
not, this might cause the problem. AFAIK delo cannot handle the config file
on one and the kernel on another partition. Flo, Thiemo?

To get the box booted, you can netboot the installed system with the image
from

http://people.debian.org/~merker/experimental_packages/bf-pre3.0.24-20021224/unpacked/r3k-kn02/linux.bin

which is an ELF kernel image that can be booted via MOP ("boot 3/mop
console=ttyS0" should do it).

HTH,
Karsten
-- 
#include <standard_disclaimer>
Nach Paragraph 28 Abs. 3 Bundesdatenschutzgesetz widerspreche ich der Nutzung
oder Uebermittlung meiner Daten fuer Werbezwecke oder fuer die Markt- oder
Meinungsforschung.
