Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Oct 2002 14:21:48 +0200 (CEST)
Received: from iris1.csv.ica.uni-stuttgart.de ([129.69.118.2]:97 "EHLO
	iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S1123915AbSJBMVr>; Wed, 2 Oct 2002 14:21:47 +0200
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp (Exim 3.36 #2)
	id 17wiVY-00324z-00
	for linux-mips@linux-mips.org; Wed, 02 Oct 2002 14:21:40 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 17wiVX-00008g-00
	for <linux-mips@linux-mips.org>; Wed, 02 Oct 2002 14:21:39 +0200
Date: Wed, 2 Oct 2002 14:21:39 +0200
To: linux-mips@linux-mips.org
Subject: Re: some indy question
Message-ID: <20021002122139.GB4801@rembrandt.csv.ica.uni-stuttgart.de>
References: <20021002055935.GA12393@csola.ugyvitelszolgaltato.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021002055935.GA12393@csola.ugyvitelszolgaltato.hu>
User-Agent: Mutt/1.4i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 330
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Attila Szabo wrote:
> Hi,
> 
> When I try to use the external cdrom on my Indy,
> the machine produces scsi errors, like command timeout and
> I have to reboot with sysrq.
> I tried two harddisks but the same.Under Irix it is
> working with the same scsi id-s.
> Is there a bug around cdrom,sr_mod or something to know
> about the external cdroms under 2.4.17 ?
> It is working with external harddisk.
> I use 2.4.17, woody.

FYI, I have similiar problems with both internal and external
cdroms on my I2. The hardware works fine under IRIX.


Thiemo
