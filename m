Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Nov 2005 19:26:19 +0000 (GMT)
Received: from extgw-uk.mips.com ([62.254.210.129]:20504 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133821AbVKBTZw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 2 Nov 2005 19:25:52 +0000
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id jA2JQPwA005928;
	Wed, 2 Nov 2005 19:26:25 GMT
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id jA2JQO6F005927;
	Wed, 2 Nov 2005 19:26:24 GMT
Date:	Wed, 2 Nov 2005 19:26:24 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Sathesh Babu Edara <satheshbabu.edara@analog.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Linux-2.6.12 code base for linux-mips
Message-ID: <20051102192624.GA3725@linux-mips.org>
References: <20051029101445.GC2935@linux-mips.org> <200511021530.jA2FUTrn015102@lilac.hdcindia.analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511021530.jA2FUTrn015102@lilac.hdcindia.analog.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9405
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Nov 02, 2005 at 09:06:16PM +0530, Sathesh Babu Edara wrote:

>  - I would like to know the code base for  linux-2.6.12 (linux_2_6_12 tag)
> in the CVS repository is same as the one in the git repository
> archive(linux-2.6.12). 

It should be; the tags in the git archive were automatically generated,
not converted fromt he CVS archive.

>  - I am new to GIT.In order   to checkout linux-2.6.12 tag from git
> repository I followed the  commands given in the
> http://www.linux-mips.org/wiki/Git web site
> 
> 
> - It is hanging while cloning the repository using the below command  
>     # git clone rsync://ftp.linux-mips.org/git/linux.git linux.git
> - Then i used http:// instead of rsync:// in the above command and it is
> working fine.

We told you before - you're behind a firewall and can't use rsync.  Unless
you have an argument with your firewall admin and those are usually a
rather stuborn kind of character when it comes to that kind of changes :)

> In the "Status of CVS to GIT conversion " section, there is no information
> on linux-2.6.12 tag/branch.If I want to checkout linux-2.6.12 tag from GIT
> repository what command  I should use after cloning the git repository.

I certainly won't list each of the hundreds of individual tags on that
page; no point in that.  ANyway, after the clone finished, do:

git-read-tree -m $(cat .git/refs/tags/linux-2.6.12)
git-checkout-index -f -a -u -q

Git developers didn't make that too easy; the git-checkout command doesn't
accept a tag as it's argument, so git-checkout linux-2.6.12 doesn't work.

  Ralf
