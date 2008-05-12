Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 May 2008 16:14:33 +0100 (BST)
Received: from gv-out-0910.google.com ([216.239.58.184]:18103 "EHLO
	gv-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20032444AbYELPO3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 12 May 2008 16:14:29 +0100
Received: by gv-out-0910.google.com with SMTP id e6so288535gvc.2
        for <linux-mips@linux-mips.org>; Mon, 12 May 2008 08:14:24 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=RPIr8EPjhwNGg/d+3Z6c15JAA0vY1h5+Zj0fll9ZxT4=;
        b=aFKIfBk/3HMC4IepxN+ImvQC/3nblayZzpYQ8TaoleTgf4EHUz9ela588SrsvzsrYEzx9Oay7UC2IPbA+/cLekzRrAOWxwrl1ydCu6yTm2F0dLUDlt/OKQqfI8s5k4DhK/f0GVEVE9Eea+f+PmSa7hHRWljedc5vY6xNQH0nRvE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pMwPRegF6KYZgBVKdNXwHfgtzqs3B8VkRW8rDlMQnT/wLUKQX3jMK6KxAVVrSXctqhT3f9p7rk2z7zA3pKyMGa96cZP0TdzoGFr1NhDmAzHBuu3e7Ny479g6BNPFlp6P35NgRV4bknroTfQWcjPnZirX8BrumzT+Px6SyjfERyM=
Received: by 10.150.91.17 with SMTP id o17mr8291944ybb.223.1210605263017;
        Mon, 12 May 2008 08:14:23 -0700 (PDT)
Received: by 10.150.140.6 with HTTP; Mon, 12 May 2008 08:14:23 -0700 (PDT)
Message-ID: <90edad820805120814l7ee3f5d3h7f9939854bccf0@mail.gmail.com>
Date:	Mon, 12 May 2008 19:14:23 +0400
From:	"Dmitri Vorobiev" <dmitri.vorobiev@gmail.com>
To:	"Martin Michlmayr" <tbm@cyrius.com>
Subject: Re: ext4dev build failure on mips: "empty_zero_page" undefined
Cc:	"Theodore Tso" <tytso@mit.edu>, linux-mips@linux-mips.org,
	linux-ext4@vger.kernel.org
In-Reply-To: <20080512145836.GE15866@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20080512130604.GA15008@deprecation.cyrius.com>
	 <90edad820805120654n50f7a00cm3c7b4a4f9346d5ea@mail.gmail.com>
	 <20080512143426.GB7029@mit.edu>
	 <20080512145836.GE15866@deprecation.cyrius.com>
Return-Path: <dmitri.vorobiev@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19219
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@gmail.com
Precedence: bulk
X-list: linux-mips

2008/5/12 Martin Michlmayr <tbm@cyrius.com>:
> * Theodore Tso <tytso@mit.edu> [2008-05-12 10:34]:
>
> > What is the Linux-mips' team preference for feeding this patch to
>  > Linus?  This technically isn't a regression, since it was broken in
>  > 2.6.25, but it would be nice to get this to Linus sooner rather than
>
>  Actually, it built just fine with 2.6.25.

It was April 29th 2008 when commit
093a088b76352e0a6fdca84eb78b3aa65fbe6dd1 where the ext4_ext_zeroout()
routine was introduced (it is this routine that makes use of the
ZERO_PAGE macro expanding to an expression that contains a reference
to the empty_zero_page global symbol). After this commit, the patches
similar to the one found in this thread were made for several
architectures. Apparently, MIPS has been overlooked.

Dmitri
