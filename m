Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Jan 2004 12:45:26 +0000 (GMT)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:13131
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225305AbUATMpZ>; Tue, 20 Jan 2004 12:45:25 +0000
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1AivFv-0003w2-00; Tue, 20 Jan 2004 13:45:19 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1AivFu-0008S0-00; Tue, 20 Jan 2004 13:45:18 +0100
Date: Tue, 20 Jan 2004 13:45:18 +0100
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-mips@linux-mips.org
Subject: Re: Support for newer gcc/gas options
Message-ID: <20040120124518.GY22218@rembrandt.csv.ica.uni-stuttgart.de>
References: <20031223114644.GA5458@sonycom.com> <Pine.LNX.4.55.0312231303030.27594@jurand.ds.pg.gda.pl> <Pine.LNX.4.55.0401201332080.12841@jurand.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0401201332080.12841@jurand.ds.pg.gda.pl>
User-Agent: Mutt/1.5.4i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4057
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:
[snip]
>  It took a bit longer than I planned, sorry.  Anyway, here are two
> functionally equivalent patches, for 2.4 and the head, that remove an ISA
> specification if a tool supports "-march=" and "-mabi=" at the same time.  

FYI:
A test for the existence of -march= should be enough, -mabi= was
implemented earlier. OTOH, it does no harm to check both.


Thiemo
