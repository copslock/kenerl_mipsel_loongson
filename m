Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Sep 2013 15:52:04 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:51224 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6860908Ab3IRNv6wsqVx (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 18 Sep 2013 15:51:58 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id r8IDpvCY030260;
        Wed, 18 Sep 2013 15:51:57 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id r8IDpu2V030259;
        Wed, 18 Sep 2013 15:51:56 +0200
Date:   Wed, 18 Sep 2013 15:51:56 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Markos Chandras <Markos.Chandras@imgtec.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH v2] MIPS: ath79: Avoid using unitialized 'reg' variable
Message-ID: <20130918135156.GO22468@linux-mips.org>
References: <1377082042-4219-1-git-send-email-markos.chandras@imgtec.com>
 <20130903133839.GA10563@linux-mips.org>
 <5225EC3B.1070701@imgtec.com>
 <20130918134533.GN22468@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20130918134533.GN22468@linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37866
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Wed, Sep 18, 2013 at 03:45:33PM +0200, Ralf Baechle wrote:

> So here's a small test case to demonstrate the issue:
> 
> /*
>  * Definition of BUG taken from asm-generic/bug.h for the CONFIG_BUG=n case
>  */
> #define BUG() 	do {} while(0)
> 
> int foo(int arg)
> {
> 	int res;
> 
> 	if (arg == 1)
> 		res = 23;
> 	else if (arg -= 2)

I fatfingered the testcase while editing the email.  this line of course
is "else if (arg == 2)"

  Ralf
