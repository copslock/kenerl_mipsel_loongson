Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Oct 2002 23:50:06 +0200 (CEST)
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:42465 "EHLO
	lacrosse.corp.redhat.com") by linux-mips.org with ESMTP
	id <S1122978AbSJOVuF>; Tue, 15 Oct 2002 23:50:05 +0200
Received: from free.redhat.lsd.ic.unicamp.br (aoliva2.cipe.redhat.com [10.0.1.156])
	by lacrosse.corp.redhat.com (8.11.6/8.9.3) with ESMTP id g9FLnLP31831;
	Tue, 15 Oct 2002 17:49:22 -0400
Received: from free.redhat.lsd.ic.unicamp.br (localhost.localdomain [127.0.0.1])
	by free.redhat.lsd.ic.unicamp.br (8.12.5/8.12.5) with ESMTP id g9FLnLGj006177;
	Tue, 15 Oct 2002 18:49:21 -0300
Received: (from aoliva@localhost)
	by free.redhat.lsd.ic.unicamp.br (8.12.5/8.12.5/Submit) id g9FLnIkJ006173;
	Tue, 15 Oct 2002 18:49:18 -0300
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Paul Koning <pkoning@equallogic.com>, wilson@redhat.com,
	hjl@lucon.org, rsandifo@redhat.com, linux-mips@linux-mips.org,
	gcc@gcc.gnu.org, binutils@sources.redhat.com
Subject: Re: MIPS gas relaxation still doesn't work
References: <Pine.GSO.3.96.1021015221315.23692A-100000@delta.ds2.pg.gda.pl>
From: Alexandre Oliva <aoliva@redhat.com>
Organization: GCC Team, Red Hat
Date: 15 Oct 2002 18:49:17 -0300
In-Reply-To: <Pine.GSO.3.96.1021015221315.23692A-100000@delta.ds2.pg.gda.pl>
Message-ID: <orof9vqso2.fsf@free.redhat.lsd.ic.unicamp.br>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <aoliva@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 448
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aoliva@redhat.com
Precedence: bulk
X-list: linux-mips

On Oct 15, 2002, "Maciej W. Rozycki" <macro@ds2.pg.gda.pl> wrote:

>  Hmm, how do you select right relocations that depend on the ABI selected? 

Err...  With logic similar to that the assembler uses? :-)

-- 
Alexandre Oliva   Enjoy Guarana', see http://www.ic.unicamp.br/~oliva/
Red Hat GCC Developer                 aoliva@{redhat.com, gcc.gnu.org}
CS PhD student at IC-Unicamp        oliva@{lsd.ic.unicamp.br, gnu.org}
Free Software Evangelist                Professional serial bug killer
