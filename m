Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f94GHia15570
	for linux-mips-outgoing; Thu, 4 Oct 2001 09:17:44 -0700
Received: from groucho.maths.monash.edu.au (groucho.maths.monash.edu.au [130.194.160.211])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f94GHfD15567
	for <linux-mips@oss.sgi.com>; Thu, 4 Oct 2001 09:17:41 -0700
Received: (from rjh@localhost)
	by groucho.maths.monash.edu.au (8.8.8/8.8.8) id QAA12885
	for linux-mips@oss.sgi.com; Thu, 4 Oct 2001 16:17:39 GMT
From: Robin Humble <rjh@groucho.maths.monash.edu.au>
Message-Id: <200110041617.QAA12885@groucho.maths.monash.edu.au>
Subject: Some native mips/Indy rpms
To: linux-mips@oss.sgi.com
Date: Fri, 5 Oct 2001 02:17:39 +1000 (EST)
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


I spent a while compiling up native mips/Indy rpms to add onto H.J.'s
RedHat 7.1 distro. It took a while to build these (eg. 17hrs per
compile for X) so to save people some time and effort I thought I'd
put them up for download.

Mostly they came from a recent 'rawhide' so they're somewhere between
RH7.1 and RH7.2. The exceptions are XFree4 and glibc which are from
H.J.'s SRPMs. For at least the next few weeks they're at:
  http://www.cita.utoronto.ca/~rjh/mips/

The main ones are XFree4, perl, tcsh, gtk+, glibc and gdm. But there
are lots of other rpms in there too. As far as I can tell they all
work fine.

I'm sure I did some dodgy things to a couple of them whilst making
patches and altering spec files, so don't expect those few to be
elegant or particularly portable. Those packages that I had to tweak
are available in the SRPMS dir.
openjade isn't there either (as I failed to get it to build) but
AFAICT it's not really needed.

I'm away from my Indy 'til Xmas so can't do any more unfortunately :-/

Hope it's useful to someone! :)

cheers,
robin
