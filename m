Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 Oct 2005 18:07:42 +0000 (GMT)
Received: from extgw-uk.mips.com ([62.254.210.129]:48388 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133734AbVJaSHX (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 31 Oct 2005 18:07:23 +0000
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j9VI7llp004508;
	Mon, 31 Oct 2005 18:07:47 GMT
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j9VI7kNC004507;
	Mon, 31 Oct 2005 18:07:46 GMT
Date:	Mon, 31 Oct 2005 18:07:46 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Sathesh Babu Edara <satheshbabu.edara@analog.com>
Cc:	"'Linux MIPS List'" <linux-mips@linux-mips.org>
Subject: Re: Git Repo
Message-ID: <20051031180746.GP13561@linux-mips.org>
References: <20051031144327.GA29199@linux-mips.org> <200510311739.j9VHdGrn007977@lilac.hdcindia.analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510311739.j9VHdGrn007977@lilac.hdcindia.analog.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9397
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Oct 31, 2005 at 11:15:02PM +0530, Sathesh Babu Edara wrote:

>   I installed git-snapshot-20051025 on Linux PC to checkout linux from git
> and  executed following command
> # rsync://ftp.linux-mips.org/git 
>  and I get following message
>    -bash: rsync://ftp.linux-mips.org/git: No such file or directory.

Shit in, shit out.

> I tried the following command also
> # git clone rsync://ftp.linux-mips.org/git/linux.git linux.git
>  and get following message
> ------------------------------------
> defaulting to local storage area
> warning: templates not found /home/sathesh/share/git-core/templates/
> rsync: failed to connect to ftp.linux-mips.org: Connection timed out
> rsync error: error in socket IO (code 10) at clientserver.c(83)
> ----------------------------------------
> 
> Can you suggest me what could be the problem?. Am I missed anything?.

A discussion with your firewall admin to open the rsync port.  Or use
git:// or http:// as the alternatives.

  Ralf
