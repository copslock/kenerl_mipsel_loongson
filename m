Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Feb 2006 09:50:36 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:10001 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S8133421AbWBNJu2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 14 Feb 2006 09:50:28 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 234C1F5CE7;
	Tue, 14 Feb 2006 10:56:27 +0100 (CET)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 03833-02-2; Tue, 14 Feb 2006 10:56:26 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 05D19F6256;
	Tue, 14 Feb 2006 10:53:22 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id k1E9mXRe015620;
	Tue, 14 Feb 2006 10:49:19 +0100
Date:	Tue, 14 Feb 2006 09:48:19 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Martin Michlmayr <tbm@cyrius.com>
cc:	Ralf Baechle <ralf@linux-mips.org>,
	"Peter 'p2' De Schrijver" <p2@mind.be>, linux-mips@linux-mips.org
Subject: Re: DECstation R3000 boot error
In-Reply-To: <20060213225927.GB4226@deprecation.cyrius.com>
Message-ID: <Pine.LNX.4.64N.0602140946470.14255@blysk.ds.pg.gda.pl>
References: <20060123225040.GA23576@deprecation.cyrius.com>
 <Pine.LNX.4.64N.0601241059140.11021@blysk.ds.pg.gda.pl>
 <20060124122700.GA8527@deprecation.cyrius.com>
 <Pine.LNX.4.64N.0601241227290.11021@blysk.ds.pg.gda.pl> <20060124232117.GA4165@codecarver>
 <Pine.LNX.4.64N.0601251103020.7675@blysk.ds.pg.gda.pl>
 <20060203150232.GA25701@deprecation.cyrius.com>
 <Pine.LNX.4.64N.0602061021110.32080@blysk.ds.pg.gda.pl>
 <Pine.LNX.4.64N.0602130911260.17051@blysk.ds.pg.gda.pl>
 <20060213225927.GB4226@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.87.1/1287/Mon Feb 13 22:29:18 2006 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10452
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 13 Feb 2006, Martin Michlmayr wrote:

> @@ -631,6 +633,13 @@
>  # CONFIG_FB_VIRTUAL is not set
>  
>  #
> +# Console display driver support
> +#
> +CONFIG_VGA_CONSOLE=y
> +CONFIG_DUMMY_CONSOLE=y
> +# CONFIG_FRAMEBUFFER_CONSOLE is not set
> +
> +#
>  # Logo configuration
>  #
>  CONFIG_LOGO=y

 Hmm, VGA_CONSOLE doesn't make much sense for the DECstation, does it?  
You might want to select FRAMEBUFFER_CONSOLE instead.

  Maciej
