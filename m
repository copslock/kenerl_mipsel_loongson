Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Sep 2003 22:27:03 +0100 (BST)
Received: from pix-525-pool.redhat.com ([IPv6:::ffff:66.187.233.200]:8693 "EHLO
	lacrosse.corp.redhat.com") by linux-mips.org with ESMTP
	id <S8225526AbTIVV1A>; Mon, 22 Sep 2003 22:27:00 +0100
Received: from free.redhat.lsd.ic.unicamp.br (aoliva.cipe.redhat.com [10.0.1.10])
	by lacrosse.corp.redhat.com (8.11.6/8.9.3) with ESMTP id h8MLQok00846;
	Mon, 22 Sep 2003 17:26:50 -0400
Received: from free.redhat.lsd.ic.unicamp.br (free.redhat.lsd.ic.unicamp.br [127.0.0.1])
	by free.redhat.lsd.ic.unicamp.br (8.12.10/8.12.10) with ESMTP id h8MLQmkB030745;
	Mon, 22 Sep 2003 18:26:48 -0300
Received: (from aoliva@localhost)
	by free.redhat.lsd.ic.unicamp.br (8.12.10/8.12.10/Submit) id h8MLQeeU030741;
	Mon, 22 Sep 2003 18:26:40 -0300
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Cc: Eric Christopher <echristo@redhat.com>,
	"Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	Atsushi Nemoto <nemoto@toshiba-tops.co.jp>,
	Daniel Jacobowitz <dan@debian.org>, linux-mips@linux-mips.org,
	binutils@sources.redhat.com
Subject: Re: recent binutils and mips64-linux
References: <Pine.GSO.3.96.1030919144141.9134C-100000@delta.ds2.pg.gda.pl>
	<1063988420.2537.5.camel@ghostwheel.sfbay.redhat.com>
	<20030919164119.GH13578@rembrandt.csv.ica.uni-stuttgart.de>
From: Alexandre Oliva <aoliva@redhat.com>
Organization: GCC Team, Red Hat
Date: 22 Sep 2003 18:26:40 -0300
In-Reply-To: <20030919164119.GH13578@rembrandt.csv.ica.uni-stuttgart.de>
Message-ID: <ord6ds346n.fsf@free.redhat.lsd.ic.unicamp.br>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <aoliva@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3256
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aoliva@redhat.com
Precedence: bulk
X-list: linux-mips

On Sep 19, 2003, Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de> wrote:

> A third answer is to add a -msign-extend-addresses switch in the assembler.

In what sense is this different from -Wa,-mabi=n32 ?

-- 
Alexandre Oliva   Enjoy Guarana', see http://www.ic.unicamp.br/~oliva/
Red Hat GCC Developer                 aoliva@{redhat.com, gcc.gnu.org}
CS PhD student at IC-Unicamp        oliva@{lsd.ic.unicamp.br, gnu.org}
Free Software Evangelist                Professional serial bug killer
