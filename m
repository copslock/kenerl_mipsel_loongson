Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6B2VqRw032606
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 10 Jul 2002 19:31:52 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6B2Vqd4032605
	for linux-mips-outgoing; Wed, 10 Jul 2002 19:31:52 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (shaft16-f88.dialo.tiscali.de [62.246.16.88])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6B2VkRw032596
	for <linux-mips@oss.sgi.com>; Wed, 10 Jul 2002 19:31:48 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g6B2a2S08906;
	Thu, 11 Jul 2002 04:36:02 +0200
Date: Thu, 11 Jul 2002 04:36:02 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: "H. J. Lu" <hjl@lucon.org>
Cc: Jun Sun <jsun@mvista.com>, linux-mips@oss.sgi.com
Subject: Re: Malta crashes on the latest 2.4 kernel
Message-ID: <20020711043601.B3207@dea.linux-mips.net>
References: <3D2CBF73.50001@mvista.com> <20020710164900.A28911@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020710164900.A28911@lucon.org>; from hjl@lucon.org on Wed, Jul 10, 2002 at 04:49:00PM -0700
X-Accept-Language: de,en,fr
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Jul 10, 2002 at 04:49:00PM -0700, H. J. Lu wrote:

> > See the crash scene.  Anybody knows the cause?  It is strange to see the 
> > reserved exception.
> > 
> 
> The 2.4 kernel checked out around Jul  4 09:28 PDT works fine on Malta.

Jun's patch certainly is correct for some MIPS32 CPUs; others may get
away without this one.  Previous experience with pipeline hazards on MIPS
processors has shown that at times hazards may change even between minor
revisions of a CPU; documentation isn't always trustworthy about such
minor details of the pipeline.

  Ralf
