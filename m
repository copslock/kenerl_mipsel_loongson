Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 May 2008 20:37:57 +0100 (BST)
Received: from yw-out-1718.google.com ([74.125.46.158]:13511 "EHLO
	yw-out-1718.google.com") by ftp.linux-mips.org with ESMTP
	id S20032059AbYELThz (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 12 May 2008 20:37:55 +0100
Received: by yw-out-1718.google.com with SMTP id 9so1486470ywk.24
        for <linux-mips@linux-mips.org>; Mon, 12 May 2008 12:37:47 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=oDa4vgGdRqPPcz/IyZLxLDdYxRbtKEV0EB3KQlS2z3I=;
        b=sqZBNH9z57fRwv9qjbe/LZq7V5x6Z/4J3iEs+iltUbxJsEJOch1Yji77uSsG39Rw8qLTBXZroN4vcJOh4HFwxA4o+FOodfes4u6ha8eltZYw2NLS9OvpwF2/l6SLyrIhcvdw7WRXNXhFiwRStprJ5ZT0hfNbpjoC08vJ920YADc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bYRz2u+RSX6LiIU5SOIMe2xOMbtyeSSEQ7w5fgQO/p9ySjD9qolUq1gQ4GQJeCqluzs98EW4YEkPdIi+1zpHgGGnYDUKzM5WkT3NZHbgsRibM/Jq6nuTpApwBF8Di+RA8GIkRxO4XZm7Sdmd7xrUuhj918qoLbS/pC0B97x7jHY=
Received: by 10.150.52.2 with SMTP id z2mr8709747ybz.48.1210621066973;
        Mon, 12 May 2008 12:37:46 -0700 (PDT)
Received: by 10.150.140.6 with HTTP; Mon, 12 May 2008 12:37:46 -0700 (PDT)
Message-ID: <90edad820805121237r7f4b6e16g135df49cfe27499a@mail.gmail.com>
Date:	Mon, 12 May 2008 23:37:46 +0400
From:	"Dmitri Vorobiev" <dmitri.vorobiev@gmail.com>
To:	"Theodore Tso" <tytso@mit.edu>
Subject: Re: ext4dev build failure on mips: "empty_zero_page" undefined
Cc:	"Martin Michlmayr" <tbm@cyrius.com>, linux-mips@linux-mips.org,
	linux-ext4@vger.kernel.org, sfr@canb.auug.org.au
In-Reply-To: <20080512173537.GG7029@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20080512130604.GA15008@deprecation.cyrius.com>
	 <90edad820805120654n50f7a00cm3c7b4a4f9346d5ea@mail.gmail.com>
	 <20080512143426.GB7029@mit.edu>
	 <20080512145836.GE15866@deprecation.cyrius.com>
	 <90edad820805120814l7ee3f5d3h7f9939854bccf0@mail.gmail.com>
	 <20080512173537.GG7029@mit.edu>
Return-Path: <dmitri.vorobiev@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19228
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@gmail.com
Precedence: bulk
X-list: linux-mips

>
>  Yeah, I guess no one is currently doing test builds of linux-next on
>  the mips architecture.  It's likely Stephen Rothwell doesn't have
>  access to one.
>

I do that sometimes. Obviously, not frequently enough. Sorry.

If Stephen wants, I, in principle, could set up a MIPS toolchain for
him, similar to the one I use myself in my small test farm. Or assist
in doing that somehow. Stephen, what do you think of that?

Dmitri
