Received:  by oss.sgi.com id <S553907AbRBTT3G>;
	Tue, 20 Feb 2001 11:29:06 -0800
Received: from u-12-18.karlsruhe.ipdial.viaginterkom.de ([62.180.18.12]:23790
        "EHLO dea.waldorf-gmbh.de") by oss.sgi.com with ESMTP
	id <S553865AbRBTT25>; Tue, 20 Feb 2001 11:28:57 -0800
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f1J2Wom01959;
	Mon, 19 Feb 2001 03:32:50 +0100
Date:   Sun, 18 Feb 2001 20:32:50 -0600
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Justin Carlson <carlson@sibyte.com>
Cc:     linux-mips@oss.sgi.com
Subject: Re: saved_command_line, arcs_cmdline, command_line
Message-ID: <20010218203250.B1644@bacchus.dhis.org>
References: <0102171327160R.15790@plugh.sibyte.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <0102171327160R.15790@plugh.sibyte.com>; from carlson@sibyte.com on Sat, Feb 17, 2001 at 01:11:27PM -0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Sat, Feb 17, 2001 at 01:11:27PM -0800, Justin Carlson wrote:

> I'm scanning over the command line arguments stuff, and noted a few things. 
> Comments welcome.
> 
> Is there any reason saved_command_line is not architecture neutral?  Seems
> like it should live in init/main.c, if anywhere.
> 
> Why do we have arcs_cmdline[] *AND* command_line[]?  Is there any respect in
> which this isn't completely redundant?   (And misnamed, for that matter, for
> non-arcs boards?)

The ARC firmware has the stupid habit of passing in all the environment
variables as part of the command line when makes them look to the kernel
like kernel options.  So prom_init_cmdline() filters the names of those
variables which get passed by the firmware.  So what actually should happen
is removing arcs_cmdline from setup.c.

  Ralf
