Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 Oct 2005 17:45:33 +0000 (GMT)
Received: from nwd2mail3.analog.com ([137.71.25.52]:1680 "EHLO
	nwd2mail3.analog.com") by ftp.linux-mips.org with ESMTP
	id S8133734AbVJaRos (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 31 Oct 2005 17:44:48 +0000
Received: from nwd2mhb1.analog.com (nwd2mhb1.analog.com [137.71.5.12])
	by nwd2mail3.analog.com (8.12.10/8.12.10) with ESMTP id j9VHjI1c028969;
	Mon, 31 Oct 2005 12:45:18 -0500
Received: from lilac.hdcindia.analog.com ([10.121.13.31])
	by nwd2mhb1.analog.com (8.9.3 (PHNE_28810+JAGae91741)/8.9.3) with ESMTP id MAA02113;
	Mon, 31 Oct 2005 12:45:14 -0500 (EST)
Received: from SEdaraL01 ([10.82.242.37])
	by lilac.hdcindia.analog.com (8.12.10+Sun/8.12.10) with ESMTP id j9VHdGrn007977;
	Mon, 31 Oct 2005 23:09:20 +0530 (IST)
Message-Id: <200510311739.j9VHdGrn007977@lilac.hdcindia.analog.com>
From:	"Sathesh Babu Edara" <satheshbabu.edara@analog.com>
To:	"'Linux MIPS List'" <linux-mips@linux-mips.org>
Cc:	"'Ralf Baechle'" <ralf@linux-mips.org>
Subject: RE: Git Repo
Date:	Mon, 31 Oct 2005 23:15:02 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
In-Reply-To: <20051031144327.GA29199@linux-mips.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Thread-Index: AcXeKKgWBJdFCqxFQmCOzTxizZzXUAAF9qEg
X-Scanned-By: MIMEDefang 2.49 on 137.71.25.52
Return-Path: <satheshbabu.edara@analog.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9396
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: satheshbabu.edara@analog.com
Precedence: bulk
X-list: linux-mips

 Thank you.
  I installed git-snapshot-20051025 on Linux PC to checkout linux from git
and  executed following command
# rsync://ftp.linux-mips.org/git 
 and I get following message
   -bash: rsync://ftp.linux-mips.org/git: No such file or directory.

I tried the following command also
# git clone rsync://ftp.linux-mips.org/git/linux.git linux.git
 and get following message
------------------------------------
defaulting to local storage area
warning: templates not found /home/sathesh/share/git-core/templates/
rsync: failed to connect to ftp.linux-mips.org: Connection timed out
rsync error: error in socket IO (code 10) at clientserver.c(83)
----------------------------------------

Can you suggest me what could be the problem?. Am I missed anything?.

Thanks in advance.

Regards,
Sathesh

-----Original Message-----
From: Ralf Baechle [mailto:ralf@linux-mips.org] 
Sent: Monday, October 31, 2005 8:13 PM
To: Sathesh Babu Edara
Cc: 'Linux MIPS List'
Subject: Re: Git Repo

On Mon, Oct 31, 2005 at 11:54:24AM +0530, Sathesh Babu Edara wrote:

>    I too get same error message.I am new to GIT.I want to checkout
> linux-2.6.12 tag from the git archive.Can some one help me what 
> commands I should use to checkout.I am trying to connect GIT  repo via 
> gitweb from my Windows-XP system.

Gitweb is for browsing repositories only, not for checking out.

If you actually want to checkout from git I suggest you start by installing
Linux; there apparently is a Cygwin port but I expect it to be rather slow
and you may hit more interesting problems with Cygwin.

  Ralf
