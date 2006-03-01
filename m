Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Mar 2006 16:57:39 +0000 (GMT)
Received: from mipsfw.mips-uk.com ([194.74.144.146]:32526 "EHLO
	bacchus.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133604AbWCAQ53 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 1 Mar 2006 16:57:29 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.4/8.13.4) with ESMTP id k21H4Jg3024777;
	Wed, 1 Mar 2006 17:04:19 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k21H4J4F024776;
	Wed, 1 Mar 2006 17:04:19 GMT
Date:	Wed, 1 Mar 2006 17:04:18 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Geoff Levand <geoffrey.levand@am.sony.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: git trouble
Message-ID: <20060301170418.GA22739@linux-mips.org>
References: <4405D0D8.7030704@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4405D0D8.7030704@am.sony.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10706
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Mar 01, 2006 at 08:50:32AM -0800, Geoff Levand wrote:

> I'm having this problem lately...  Any help?
> 
> $ cg-clone http://www.linux-mips.org/pub/scm/linux.git linux-mips.git
> defaulting to local storage area
> 08:45:45 URL:http://www.linux-mips.org/pub/scm/linux.git/HEAD [23/23] -> "refs/heads/.origin-fetching" [1]
> error: Could not interpret ref: refs/heads/master as something to pull
> cg-fetch: objects fetch failed
> cg-clone: fetch failed

HEAD used to be a symlink; more recent versions of git which try to
support operating systems without symlinks put something like
"ref: refs/heads/master" into that file.  I suspect your cogito is
simply too old to grok that.

  Ralf
