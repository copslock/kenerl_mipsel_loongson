Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9OMnXI08327
	for linux-mips-outgoing; Wed, 24 Oct 2001 15:49:33 -0700
Received: from ns.snowman.net (ns.snowman.net [63.80.4.34])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9OMnVD08323
	for <linux-mips@oss.sgi.com>; Wed, 24 Oct 2001 15:49:31 -0700
Received: from localhost (nick@localhost)
	by ns.snowman.net (8.9.3/8.9.3/Debian 8.9.3-21) with ESMTP id SAA29896;
	Wed, 24 Oct 2001 18:49:17 -0400
Date: Wed, 24 Oct 2001 18:49:17 -0400 (EDT)
From: <nick@snowman.net>
X-Sender: nick@ns
To: Lukas Hejtmanek <xhejtman@mail.muni.cz>
cc: linux-mips@oss.sgi.com
Subject: Re: Origin 200
In-Reply-To: <20011024230601.B2045@mail.muni.cz>
Message-ID: <Pine.LNX.4.21.0110241848550.25602-100000@ns>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from QUOTED-PRINTABLE to 8bit by oss.sgi.com id f9OMnVD08325
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

That's exactly the issues I was running into.  Talk to Ralf.  Erm, is it a
company system?
	Nick

On Wed, 24 Oct 2001, Lukas Hejtmanek wrote:

> On Wed, Oct 24, 2001 at 04:48:13PM -0400, nick@snowman.net wrote:
> > I had very similar problems, where does it oops?  I lost access to the origin
> > that was haveing problems before tracking it down :(.  Nick
> 
> It seems to be at random place. I don't know what correct boot mesages look
> like. Few times it freezed after amount memmory message, few times after message
> about RT Link socket (or somewhat), sometimes after serial driver initialized.
> Once it freezed after scsi driver loaded. I think it has nothing to do with any
> driver because the same kernel freez or oops at different place.
> 
> Do you have any idea how to track it down?
> 
> -- 
> Luká¹ Hejtmánek
> 
