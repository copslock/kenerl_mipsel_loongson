Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g62KdTRw023856
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 2 Jul 2002 13:39:29 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g62KdTdv023855
	for linux-mips-outgoing; Tue, 2 Jul 2002 13:39:29 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from ubik.localnet (port48.ds1-vbr.adsl.cybercity.dk [212.242.58.113])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g62KdMRw023822
	for <linux-mips@oss.sgi.com>; Tue, 2 Jul 2002 13:39:23 -0700
Received: from murphy.dk (brian.localnet [10.0.0.2])
	by ubik.localnet (8.12.3/8.12.2/Debian -5) with ESMTP id g62KhCXK012716
	for <linux-mips@oss.sgi.com>; Tue, 2 Jul 2002 22:43:13 +0200
Message-ID: <3D221060.80602@murphy.dk>
Date: Tue, 02 Jul 2002 22:43:12 +0200
From: Brian Murphy <brian@murphy.dk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020412 Debian/0.9.9-6
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips <linux-mips@oss.sgi.com>
Subject: Re: Patch for NEC VR5000 support (part 1 of several for lasat board
 support)
References: <3D21FF19.5020606@murphy.dk> <20020702220227.A9566@dea.linux-mips.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, hits=0.6 required=5.0 tests=TO_LOCALPART_EQ_REAL version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ralf Baechle wrote:

 >On Tue, Jul 02, 2002 at 09:29:29PM +0200, Brian Murphy wrote:
 >
 >>I have attached a patch which applies to the 2.4 branch and adds
 >>support for the NEC VR5000. This would be a first step in
 >>adding support for the Lasat architectures.
 >>
 >>A comment from someone with cvs commit access would be nice
 >>this time.
 >>
 >
 >As NEC's VR5000 is a plain normal R5000 why are you duplicating the
 >processor support with slight variations?
 >
 >  Ralf
 >
I believe the problem is in the (lack of) secondary cache support when
the R5000 target is selected in the standard kernel. I thought that 
making a seperate VR5000 cpu was then a safer option leaving the R5000
as it is and presumably working on the platforms it is used on. I have
no possibility of testing on those platforms to ensure any integration
is successful.

/Brian
