Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.6/8.11.3) id g31MGu401863
	for linux-mips-outgoing; Mon, 1 Apr 2002 14:16:56 -0800
Received: from mailhost.uni-koblenz.de (root@mailhost.uni-koblenz.de [141.26.64.1])
	by oss.sgi.com (8.11.6/8.11.3) with SMTP id g31MGpo01830;
	Mon, 1 Apr 2002 14:16:51 -0800
Received: from eddie (eddie.uni-koblenz.de [141.26.64.59])
	by mailhost.uni-koblenz.de (8.11.6/8.11.6/SuSE Linux 0.5) with SMTP id g31MGnt00419;
	Tue, 2 Apr 2002 00:16:49 +0200
Received: from dea.linux-mips.net by eddie (SMI-8.6/KO-2.0)
	id AAA20962; Tue, 2 Apr 2002 00:16:48 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g31MGe103667;
	Mon, 1 Apr 2002 14:16:40 -0800
Date: Mon, 1 Apr 2002 14:16:40 -0800
From: Ralf Baechle <ralf@oss.sgi.com>
To: Florian Lohoff <flo@rfc822.org>
Cc: Raoul Borenius <raoul@shuttle.de>, linux-mips@oss.sgi.com,
   devfs@oss.sgi.com
Subject: Re: broken devfs-support in SGI Zilog8530 serial driver
Message-ID: <20020401141640.A3643@dea.linux-mips.net>
References: <20020329103244.GA15765@bunny.shuttle.de> <20020329233559.A31160@dea.linux-mips.net> <20020330132856.GA24305@bunny.shuttle.de> <20020331150023.GA30224@bunny.shuttle.de> <20020401192957.GA1389@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020401192957.GA1389@paradigm.rfc822.org>; from flo@rfc822.org on Mon, Apr 01, 2002 at 09:29:57PM +0200
X-Accept-Language: de,en,fr
X-Virus-Scanned: by AMaViS-perl11-milter (http://amavis.org/)
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Apr 01, 2002 at 09:29:57PM +0200, Florian Lohoff wrote:

> > Could you commit that too?
> > 
> 
> I thought the callout devices are officially "dead" and should disappear
> "Real Soon Now(tm)" as beeing a locking hell and unneeded.

Really Soon Now doesn't mean what you want it to mean in a world that is
driven by backward compatibility ...

  Ralf
