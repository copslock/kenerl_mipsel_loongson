Received: from pneumatic-tube.sgi.com (pneumatic-tube.sgi.com [204.94.214.22])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id AAA01183
	for <pstadt@stud.fh-heilbronn.de>; Wed, 7 Jul 1999 00:38:09 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id PAA4660687; Tue, 6 Jul 1999 15:34:29 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA65648
	for linux-list;
	Tue, 6 Jul 1999 15:28:38 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA51842;
	Tue, 6 Jul 1999 15:27:52 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1] (may be forged)) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA03813; Tue, 6 Jul 1999 15:27:50 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (cacc-28.uni-koblenz.de [141.26.131.28])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id AAA28457;
	Wed, 7 Jul 1999 00:27:47 +0200 (MET DST)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.9.3/8.9.3) id PAA28855;
	Tue, 6 Jul 1999 15:05:49 +0200
Date: Tue, 6 Jul 1999 15:05:49 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: "William J. Earl" <wje@fir.engr.sgi.com>
Cc: Ulf Carlsson <ulfc@thepuffingroup.com>, linux@cthulhu.engr.sgi.com,
        linux-mips@fnet.fr, linux-mips@vger.rutgers.edu
Subject: Re: Memory corruption
Message-ID: <19990706150549.A28849@uni-koblenz.de>
References: <19990622033931.A7201@thepuffingroup.com> <199906300101.SAA09334@fir.engr.sgi.com> <19990630044702.A6969@thepuffingroup.com> <199906302201.PAA29334@fir.engr.sgi.com> <19990701022357.D30652@uni-koblenz.de> <199907010053.RAA00061@fir.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <199907010053.RAA00061@fir.engr.sgi.com>; from William J. Earl on Wed, Jun 30, 1999 at 05:53:58PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

I've received a report from some person who is working on his own R3081
port.  He also observes data corruption and suspects reading of swapped
pages is causing that.

Sigh,

  Ralf
