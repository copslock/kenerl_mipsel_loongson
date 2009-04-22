Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Apr 2009 11:47:32 +0100 (BST)
Received: from mx1.moondrake.net ([212.85.150.166]:56240 "EHLO
	mx1.mandriva.com") by ftp.linux-mips.org with ESMTP
	id S20021600AbZDVKrZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 22 Apr 2009 11:47:25 +0100
Received: by mx1.mandriva.com (Postfix, from userid 501)
	id 21D1F274010; Wed, 22 Apr 2009 12:47:24 +0200 (CEST)
Received: from office-abk.mandriva.com (office-abk.mandriva.com [84.55.162.90])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.mandriva.com (Postfix) with ESMTP id 24D8E27400C;
	Wed, 22 Apr 2009 12:47:23 +0200 (CEST)
Received: from anduin.mandriva.com (fw2.mandriva.com [192.168.2.3])
	by office-abk.mandriva.com (Postfix) with ESMTP id 3F5D6828BE;
	Wed, 22 Apr 2009 12:50:53 +0200 (CEST)
Received: from anduin.mandriva.com (localhost [127.0.0.1])
	by anduin.mandriva.com (Postfix) with ESMTP id F08AEFF855;
	Wed, 22 Apr 2009 12:50:36 +0200 (CEST)
From:	Arnaud Patard <apatard@mandriva.com>
To:	fredtan <tanflying@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: how to clear the D_cache and I_cache in the MIPS linux ?
References: <23172497.post@talk.nabble.com>
Organization: Mandriva
Date:	Wed, 22 Apr 2009 12:50:36 +0200
In-Reply-To: <23172497.post@talk.nabble.com> (fredtan's message of "Wed, 22 Apr 2009 02:08:13 -0700 (PDT)")
Message-ID: <m31vrlgdxf.fsf@anduin.mandriva.com>
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/22.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <arnaud.patard@mandriva.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22417
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: apatard@mandriva.com
Precedence: bulk
X-list: linux-mips

fredtan <tanflying@gmail.com> writes:

> D_CACHE,then invalidate I_CACHE,then run the code. My MIPS does not have
> SYNCI instruction,Cache 
>
> instruction is a privilege instruction, the program has no right to use it.
> So , What can I do ?

use cacheflush()

Arnaud
