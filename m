Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Oct 2008 08:10:38 +0100 (BST)
Received: from monty.telenet-ops.be ([195.130.132.56]:21929 "EHLO
	monty.telenet-ops.be") by ftp.linux-mips.org with ESMTP
	id S21545003AbYJOHKg (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 15 Oct 2008 08:10:36 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
	by monty.telenet-ops.be (Postfix) with SMTP id 6139E54043;
	Wed, 15 Oct 2008 09:10:35 +0200 (CEST)
Received: from anakin.of.borg (d54C15368.access.telenet.be [84.193.83.104])
	by monty.telenet-ops.be (Postfix) with ESMTP id 3574854054;
	Wed, 15 Oct 2008 09:10:35 +0200 (CEST)
Received: from anakin.of.borg (localhost [127.0.0.1])
	by anakin.of.borg (8.14.3/8.14.3/Debian-5) with ESMTP id m9F7AYeV023411
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 15 Oct 2008 09:10:34 +0200
Received: from localhost (geert@localhost)
	by anakin.of.borg (8.14.3/8.14.3/Submit) with ESMTP id m9F7AXVf023408;
	Wed, 15 Oct 2008 09:10:34 +0200
X-Authentication-Warning: anakin.of.borg: geert owned process doing -bs
Date:	Wed, 15 Oct 2008 09:10:33 +0200 (CEST)
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	David Daney <ddaney@caviumnetworks.com>
cc:	linux-mips@linux-mips.org, dvomlehn@cisco.com,
	"Paoletti, Tomaso" <Tomaso.Paoletti@caviumnetworks.com>
Subject: Re: [PATCH] MIPS: Rewrite cpu_to_name so it has one statement per
 line (version 2).
In-Reply-To: <48F51BF7.2040906@caviumnetworks.com>
Message-ID: <Pine.LNX.4.64.0810150908430.25759@anakin>
References: <48F51BF7.2040906@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20768
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Tue, 14 Oct 2008, David Daney wrote:
> +static const char *mips_cpu_names[] = {

    [...]

> +	[CPU_LAST]		= NULL
> +};

> +	if (c->cputype >= CPU_LAST)
                       ^^
Either you can use `>' here, or remove the [CPU_LAST] entry in
mips_cpu_names[].

> +		BUG();
> +	name = mips_cpu_names[c->cputype];
> +	if (!name)
> 		BUG();
> -	}
> -
> 	return name;
> }

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
