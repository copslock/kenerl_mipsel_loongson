Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 Oct 2005 18:09:43 +0000 (GMT)
Received: from alpha.total-knowledge.com ([205.217.158.170]:40143 "EHLO
	total-knowledge.com") by ftp.linux-mips.org with ESMTP
	id S8133734AbVJaSJZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 31 Oct 2005 18:09:25 +0000
Received: (qmail 7932 invoked from network); 31 Oct 2005 10:02:10 -0800
Received: from unknown (HELO ?10.50.163.242?) (ilya@209.157.142.204)
  by alpha.total-knowledge.com with ESMTPA; 31 Oct 2005 10:02:10 -0800
Message-ID: <43665DED.9030302@total-knowledge.com>
Date:	Mon, 31 Oct 2005 10:09:49 -0800
From:	"Ilya A. Volynets-Evenbakh" <ilya@total-knowledge.com>
Organization: Total Knowledge
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051015)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Sathesh Babu Edara <satheshbabu.edara@analog.com>
CC:	'Linux MIPS List' <linux-mips@linux-mips.org>,
	'Ralf Baechle' <ralf@linux-mips.org>
Subject: Re: Git Repo
References: <200510311739.j9VHdGrn007977@lilac.hdcindia.analog.com>
In-Reply-To: <200510311739.j9VHdGrn007977@lilac.hdcindia.analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <ilya@total-knowledge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9398
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ilya@total-knowledge.com
Precedence: bulk
X-list: linux-mips

You are behind firewall that does not allow rsync access.
Use http://www.linux-mips.org/pub/scm/linux.git instead.

Sathesh Babu Edara wrote:

> Thank you.
>  I installed git-snapshot-20051025 on Linux PC to checkout linux from git
>and  executed following command
># rsync://ftp.linux-mips.org/git 
> and I get following message
>   -bash: rsync://ftp.linux-mips.org/git: No such file or directory.
>
>I tried the following command also
># git clone rsync://ftp.linux-mips.org/git/linux.git linux.git
> and get following message
>------------------------------------
>defaulting to local storage area
>warning: templates not found /home/sathesh/share/git-core/templates/
>rsync: failed to connect to ftp.linux-mips.org: Connection timed out
>rsync error: error in socket IO (code 10) at clientserver.c(83)
>----------------------------------------
>
>Can you suggest me what could be the problem?. Am I missed anything?.
>
>Thanks in advance.
>
>Regards,
>Sathesh
>
>-----Original Message-----
>From: Ralf Baechle [mailto:ralf@linux-mips.org] 
>Sent: Monday, October 31, 2005 8:13 PM
>To: Sathesh Babu Edara
>Cc: 'Linux MIPS List'
>Subject: Re: Git Repo
>
>On Mon, Oct 31, 2005 at 11:54:24AM +0530, Sathesh Babu Edara wrote:
>
>  
>
>>   I too get same error message.I am new to GIT.I want to checkout
>>linux-2.6.12 tag from the git archive.Can some one help me what 
>>commands I should use to checkout.I am trying to connect GIT  repo via 
>>gitweb from my Windows-XP system.
>>    
>>
>
>Gitweb is for browsing repositories only, not for checking out.
>
>If you actually want to checkout from git I suggest you start by installing
>Linux; there apparently is a Cygwin port but I expect it to be rather slow
>and you may hit more interesting problems with Cygwin.
>
>  Ralf
>
>
>  
>

-- 
Ilya A. Volynets-Evenbakh
Total Knowledge. CTO
http://www.total-knowledge.com
