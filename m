Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8J12js12063
	for linux-mips-outgoing; Tue, 18 Sep 2001 18:02:45 -0700
Received: from dea.linux-mips.net (u-114-21.karlsruhe.ipdial.viaginterkom.de [62.180.21.114])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8J12ge12060
	for <linux-mips@oss.sgi.com>; Tue, 18 Sep 2001 18:02:42 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id f8J12J302544;
	Wed, 19 Sep 2001 03:02:19 +0200
Date: Wed, 19 Sep 2001 03:02:19 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Gerald Champagne <gerald.champagne@esstech.com>
Cc: Zhang Fuxin <fxzhang@ict.ac.cn>,
   "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: Freeing global memory used only by __init functions
Message-ID: <20010919030219.B2161@dea.linux-mips.net>
References: <200109181808.LAA05245@mail.esstech.com> <3BA7946B.4070806@esstech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BA7946B.4070806@esstech.com>; from gerald.champagne@esstech.com on Tue, Sep 18, 2001 at 01:37:31PM -0500
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Sep 18, 2001 at 01:37:31PM -0500, Gerald Champagne wrote:

> Can someone point to a set of rules for submitting patches
> for linux-mips?  I'm familiar with the methods used for the
> kernel.  Is this the same?  I'm using 2.4.3 from the mips site.
> Can I patch against that, or do I have to start from a
> certain cvs version?

Please send unified diffs relative to the latest revision of the CVS
archive from oss.sgi.com to me by mail.  Same rulesSee
http://oss.sgi.com/mips/mips-howto.html for how to access CVS.  See also
Documentation/SubmittingPatches in your kernel tree.

  Ralf
