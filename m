Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g26MHKa01709
	for linux-mips-outgoing; Wed, 6 Mar 2002 14:17:20 -0800
Received: from dea.linux-mips.net (a1as01-p11.stg.tli.de [195.252.185.11])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g26MHG901705
	for <linux-mips@oss.sgi.com>; Wed, 6 Mar 2002 14:17:16 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g26LGm017260;
	Wed, 6 Mar 2002 22:16:48 +0100
Date: Wed, 6 Mar 2002 22:16:48 +0100
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Kevin D. Kissell" <kevink@mips.com>
Cc: Sanjay Jain <sjain@Sanera.net>, linux-mips@oss.sgi.com
Subject: Re: unhandled kernel  unaligned access
Message-ID: <20020306221648.A17128@dea.linux-mips.net>
References: <MPEHJBMAKDIKNMNLMJCLIELJCBAA.sjain@sanera.net> <3C867007.FB94B0D@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C867007.FB94B0D@mips.com>; from kevink@mips.com on Wed, Mar 06, 2002 at 11:37:44AM -0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Mar 06, 2002 at 11:37:44AM -0800, Kevin D. Kissell wrote:

> Which sources are you using?  Up until pretty recently,
> there was a bug in unaligned.c which could cause this.
> I don't know when it was fixed at SGI, but the fix
> is in the 2.4.19-pre2 sources at kernel.org.

2.4.19-pre2 has most of the oss.sgi.com code as of about a week ago.

  Ralf
