Received:  by oss.sgi.com id <S42212AbQILQPW>;
	Tue, 12 Sep 2000 09:15:22 -0700
Received: from Cantor.suse.de ([194.112.123.193]:25861 "HELO Cantor.suse.de")
	by oss.sgi.com with SMTP id <S42209AbQILQPK>;
	Tue, 12 Sep 2000 09:15:10 -0700
Received: from Hermes.suse.de (Hermes.suse.de [194.112.123.136])
	by Cantor.suse.de (Postfix) with ESMTP
	id 8CA671E3CE; Tue, 12 Sep 2000 18:15:08 +0200 (MEST)
Received: from arthur.inka.de (Galois.suse.de [10.0.0.1])
	by Hermes.suse.de (Postfix) with ESMTP
	id DFE5410A02A; Tue, 12 Sep 2000 18:15:02 +0200 (MEST)
Received: from gromit.rhein-neckar.de ([192.168.27.3] ident=postfix)
	by arthur.inka.de with esmtp (Exim 3.14 #1)
	id 13YshE-0006Wt-00; Tue, 12 Sep 2000 18:14:08 +0200
Received: by gromit.rhein-neckar.de (Postfix, from userid 207)
	id 9BD581822; Tue, 12 Sep 2000 18:14:07 +0200 (CEST)
Mail-Copies-To: never
To:     Ralf Baechle <ralf@oss.sgi.com>
Cc:     Ulf Carlsson <ulfc@engr.sgi.com>,
        Keith M Wesolowski <wesolows@foobazco.org>,
        "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, linux-mips@oss.sgi.com,
        linux-mips@fnet.fr
Subject: Re: One more gcc patch
References: <20000908205810.A11920@bacchus.dhis.org>
From:   Andreas Jaeger <aj@suse.de>
Date:   12 Sep 2000 18:14:07 +0200
In-Reply-To: Ralf Baechle's message of "Fri, 8 Sep 2000 20:58:11 +0200"
Message-ID: <u8ya0xbnao.fsf@gromit.rhein-neckar.de>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Channel Islands)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

>>>>> Ralf Baechle writes:

 > Ooops, this fixes a bug in the previous patch for gcc-current.  So this
 > patch does:

 >  - fix constructors which were not run for shared libs
 >  - fix warnings when building the compiler itself
 >  - Keith's gcse patch
 >  - gcc was generating code which was calling __main from the beginning of
 >    main which is wrong for Linux

Did you run the testsuite?

It doesn't seem to fix C++:

                === libstdc++ Summary ===

# of expected passes            9
# of unexpected failures        10
# of expected failures          11

The number for g++ are even worse, I stopped the check

Any idea how to get C++ working?

Andreas
-- 
 Andreas Jaeger
  SuSE Labs aj@suse.de
   private aj@arthur.inka.de
    http://www.suse.de/~aj
