Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jun 2003 21:41:25 +0100 (BST)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:65077
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225227AbTFKUlX>; Wed, 11 Jun 2003 21:41:23 +0100
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp (Exim 3.35 #1)
	id 19QCPF-0003Lm-00; Wed, 11 Jun 2003 22:41:17 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 19QCPF-0001d5-00; Wed, 11 Jun 2003 22:41:17 +0200
Date: Wed, 11 Jun 2003 22:41:17 +0200
To: Martin Leopold <mleopold@tiscali.dk>
Cc: linux-mips@linux-mips.org
Subject: Re: Linux on Indigo2 (IP28) - R10000
Message-ID: <20030611204117.GO29687@rembrandt.csv.ica.uni-stuttgart.de>
References: <20030610181100.GB529@rembrandt.csv.ica.uni-stuttgart.de> <3EDD28A400000BAC@cpfe4.be.tisc.dk> <20030610185927.GC529@rembrandt.csv.ica.uni-stuttgart.de> <20030611203518.GA4986@asterix.cartoonnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030611203518.GA4986@asterix.cartoonnet>
User-Agent: Mutt/1.5.4i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2595
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Martin Leopold wrote:
> 
> On 2003.06.10 20:59 Thiemo Seufer wrote:
> > > I looked arround your website and saw
> > > "mips64-linux-ip28-2002-06-28.tar.gz"
> > > whoo.. Sounds exiting =]
> > I know it's somewhat outdated. :-)
> 
> Hehe.. I tried it, and it booted. Whopee.. However the kernel-level-IP 
> configuration (BOOTP) fails!? I'm not really sure why - the DHCP server 
> just gave the IP and kernel-image a moment ago. This make me wonder: 
> how far could I get with this kernel? Is it possible that I could 
> actually boot an entire system with this kernel, or is that pushing it 
> a bit?

It happens to work by accident, because the cachelines destoyed
due to the speculative stores don't hit anything important. The
2.5 kernel fails much earlier.


Thiemo
