Received:  by oss.sgi.com id <S554058AbQLBNDV>;
	Sat, 2 Dec 2000 05:03:21 -0800
Received: from orzan.fi.udc.es ([193.144.60.19]:54912 "EHLO orzan.fi.udc.es")
	by oss.sgi.com with ESMTP id <S554056AbQLBNC5>;
	Sat, 2 Dec 2000 05:02:57 -0800
Received: from serpe.mitica (mail@vexeta.dc.fi.udc.es [193.144.51.32])
	by orzan.fi.udc.es (8.9.3/8.9.1) with ESMTP id OAA18783;
	Sat, 2 Dec 2000 14:02:52 +0100 (MET)
Received: from quintela by serpe.mitica with local (Exim 3.16 #1 (Debian))
	id 142CJX-0001jV-00; Sat, 02 Dec 2000 14:02:51 +0100
To:     Florian Lohoff <flo@rfc822.org>
Cc:     linux-mips@oss.sgi.com
Subject: Re: [PATCH] DEC init_cycle_counter
References: <20001202132748.A2002@paradigm.rfc822.org>
X-Url:  http://carpanta.dc.fi.udc.es/~quintela
From:   "Juan J. Quintela" <quintela@fi.udc.es>
In-Reply-To: Florian Lohoff's message of "Sat, 2 Dec 2000 13:27:48 +0100"
Date:   02 Dec 2000 14:02:51 +0100
Message-ID: <yttwvdjj7r8.fsf@serpe.mitica>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

>>>>> "florian" == Florian Lohoff <flo@rfc822.org> writes:

florian> Comments ?

[snip]
 
florian> -char cyclecounter_available;
florian> -

[snip]
 
florian>  	if (cyclecounter_available) {
florian>  		write_32bit_cp0_register(CP0_COUNT, 0);

You delete the definition of cyclecounter_available and you mantain
one of its uses ..... that is a no-no, I will bet that with that
patch, this don't compile (and less it works .....).

Later, Juan.

-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
