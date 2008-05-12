Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 May 2008 15:46:35 +0100 (BST)
Received: from gv-out-0910.google.com ([216.239.58.188]:39592 "EHLO
	gv-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20030619AbYELOqb (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 12 May 2008 15:46:31 +0100
Received: by gv-out-0910.google.com with SMTP id e6so281362gvc.2
        for <linux-mips@linux-mips.org>; Mon, 12 May 2008 07:46:21 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=DxzrahkwK/4OBU3eNSQlGsvIJ6MiGOoYUamxH6Qhm4Q=;
        b=A9MpM7x4BEZX1l72x17VBn81nPLfVN/IJw9M1mGO9SMizAq6Cu1r8uPnLhhwDpRUI6ZNyWx3hYUbcXSYSOXzsukFQEHKVo8hoCK8OMU/gXf5LI0NL1Pfne7Ww/+YdnM/eQWSq/+S5MixRA2B+kvWrxvI5ImZQPmIwzL26FtiI+8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KpOMDTYt9vxR4rjWiXHfhO+em3CeMGX2pKF2BfYwqhsj0C4txZof5basggbxDWYypafqy7guwdtlJJri1r6dX+jH8WdMfhKTZ0teDi43xaVKGtygJT8BXuWOlNbblpcaaPWWZdX85wo4IBi/9A8OASLd3YlOQMFiTJIxKgusHQs=
Received: by 10.151.144.4 with SMTP id w4mr8253919ybn.235.1210603581064;
        Mon, 12 May 2008 07:46:21 -0700 (PDT)
Received: by 10.150.140.6 with HTTP; Mon, 12 May 2008 07:46:21 -0700 (PDT)
Message-ID: <90edad820805120746l61e67362vbd177d63e8b05dc8@mail.gmail.com>
Date:	Mon, 12 May 2008 18:46:21 +0400
From:	"Dmitri Vorobiev" <dmitri.vorobiev@gmail.com>
To:	"Theodore Tso" <tytso@mit.edu>
Subject: Re: ext4dev build failure on mips: "empty_zero_page" undefined
Cc:	"Martin Michlmayr" <tbm@cyrius.com>, linux-mips@linux-mips.org,
	linux-ext4@vger.kernel.org, ralf@linux-mips.org
In-Reply-To: <20080512143426.GB7029@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20080512130604.GA15008@deprecation.cyrius.com>
	 <90edad820805120654n50f7a00cm3c7b4a4f9346d5ea@mail.gmail.com>
	 <20080512143426.GB7029@mit.edu>
Return-Path: <dmitri.vorobiev@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19217
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@gmail.com
Precedence: bulk
X-list: linux-mips

2008/5/12 Theodore Tso <tytso@mit.edu>:
> On Mon, May 12, 2008 at 05:54:24PM +0400, Dmitri Vorobiev wrote:
>  >
>  > Yep. The export is missing. Attached patch was build-tested for a
>  > Malta config with ext4 enabled as a module.
>
>  Thanks, Dmitri!
>
>  What is the Linux-mips' team preference for feeding this patch to
>  Linus?  This technically isn't a regression, since it was broken in
>  2.6.25, but it would be nice to get this to Linus sooner rather than
>  later.  Should I push it with a batch of ext4 fixes, or do you want to
>  push it via the mips tree?  (Davem asked me to push the sparc export
>  via ext4, while the ppc arch, it went via the ppc tree.  So whichever
>  is your preference; I'm easy.  :-)
>
>                                             - Ted

Hi Ted,

Normally I push my patches via the mips tree, and now I'm Cc:ing Ralf for that.

Hopefully Ralf will react quickly. :)

Dmitri
