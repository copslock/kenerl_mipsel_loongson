Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Dec 2004 04:03:05 +0000 (GMT)
Received: from web52804.mail.yahoo.com ([IPv6:::ffff:206.190.39.168]:39799
	"HELO web52804.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8225281AbUL1EC5>; Tue, 28 Dec 2004 04:02:57 +0000
Received: (qmail 34539 invoked by uid 60001); 28 Dec 2004 04:02:40 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=I1gaHzf2ZiCDizaqb7JlJwCH/rIWdikP/KDBAqRpsEKI8GSEyY4AfO+bJdc0WrBVo+U3z8sC2cUSX7Q8KyDV7QnSAMnwzNyw68n75srOZkI7x7DFRcNoTKffo2tuwHqi1d3xZnMStxr6HQCEiueI/eEN8O4pcDra+pQoaGk8HYw=  ;
Message-ID: <20041228040240.34537.qmail@web52804.mail.yahoo.com>
Received: from [203.145.153.155] by web52804.mail.yahoo.com via HTTP; Mon, 27 Dec 2004 20:02:40 PST
Date: Mon, 27 Dec 2004 20:02:40 -0800 (PST)
From: Manish Lachwani <m_lachwani@yahoo.com>
Subject: RE: Some cache questions
To: Brad Larson <Brad_Larson@pmc-sierra.com>,
	'Thomas Petazzoni' <thomas.petazzoni@enix.org>,
	linux-mips@linux-mips.org
In-Reply-To: <04781D450CFF604A9628C8107A62FCCF013DDAE4@sjc1exm01.pmc_nt.nt.pmc-sierra.bc.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <m_lachwani@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6776
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: m_lachwani@yahoo.com
Precedence: bulk
X-list: linux-mips

Hello !

For chip revisions 1.0 and 1.1, there are some changes
to the memory management subsystem for the kernel to
work on the board (dual core). As already known, these
versions dont support Shared state.

I had made those changes to the 2.4.21 kernel. Maybe
you can take a look at those changes and port them to
2.6 appropriately. However, there is more sanity in
1.2 version

Thanks
Manish Lachwani


--- Brad Larson <Brad_Larson@pmc-sierra.com> wrote:

> You haven't mentioned which board.  If its Yosemite
> then you may have one of the few not upgraded to 1.2
> silicon.  If so it won't work with the changes
> committed by Ralf which requires the shared state
> for SMP boot.  For further discussion contact the
> apps@pmc-sierra.com
> 
> --Brad
> 
> -----Original Message-----
> From: linux-mips-bounce@linux-mips.org
> [mailto:linux-mips-bounce@linux-mips.org]On Behalf
> Of Thomas Petazzoni
> Sent: Monday, December 27, 2004 8:35 AM
> To: linux-mips@linux-mips.org
> Subject: Some cache questions
> 
> 
> Hello,
> 
> I'm using an RM9000 dual-core processor, buggy
> revisions (the one that 
> doesn't support the "Shared" cache state if I
> understood correctly).
> 
> When going through the CVS logs, I saw that Ralf
> quite recently changed 
> the cache mode from 4 to 5 in pgtable-bits.h. Is
> that change involved in 
> the use of the "Shared" cache state with newer
> RM9000 revisions that 
> don't have the bug ?
> 
> Currently, the KSEG0 cache coherency mode (2 lower
> bits of the CONFIG 
> register) is set to 3 during PMON (start.S file).
> When I write something 
> to the memory through KSEG0 with the first core, it
> doesn't appear to be 
> read by the second core. This indicates, in my
> opinion, that the cache 
> line of the first core hasn't been written to memory
> so that the second 
> core could use it. Am I right ?
> 
> If I want to correctly use both cores using KSEG0,
> should I set the mode 
> in the CONFIG register to 4 (so that I can work with
> buggy processors) ?
> 
> Thanks,
> 
> Thomas
> -- 
> PETAZZONI Thomas - thomas.petazzoni@enix.org
> http://thomas.enix.org - Jabber:
> thomas.petazzoni@jabber.dk
> http://kos.enix.org, http://sos.enix.org
> Fingerprint : 0BE1 4CF3 CEA4 AC9D CC6E  1624 F653
> CB30 98D3 F7A7
> 
> 
