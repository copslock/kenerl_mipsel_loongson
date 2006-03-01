Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Mar 2006 12:45:16 +0000 (GMT)
Received: from smtp101.mail.mud.yahoo.com ([209.191.85.211]:30080 "HELO
	smtp101.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S8133138AbWCAMpD (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 1 Mar 2006 12:45:03 +0000
Received: (qmail 70651 invoked from network); 1 Mar 2006 12:52:46 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=Vck0wRFnynPksIlhpHe0MFKs/xq7qDi0cE9Km5oWL70gXP7FHZBc4mK9G0N34I3olj9P2qljwgDS3GTqayRbt8zwE7vLySqPA6uBAyE7PXiX3+rZZw7EYwei+GA+zItMkVp+iOmYE2Q4blfipvCQwsWlIoow0ADLdkM/wcOEHtg=  ;
Received: from unknown (HELO ?192.168.0.1?) (nickpiggin@203.173.4.201 with plain)
  by smtp101.mail.mud.yahoo.com with SMTP; 1 Mar 2006 12:52:46 -0000
Message-ID: <44059915.3010800@yahoo.com.au>
Date:	Wed, 01 Mar 2006 23:52:37 +1100
From:	Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: jiffies_64 vs. jiffies
References: <20060301.144442.118975101.nemoto@toshiba-tops.co.jp> <20060301.210541.30439818.nemoto@toshiba-tops.co.jp>
In-Reply-To: <20060301.210541.30439818.nemoto@toshiba-tops.co.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <nickpiggin@yahoo.com.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10700
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nickpiggin@yahoo.com.au
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:

> @@ -924,8 +924,7 @@ static inline void update_times(void)
>  
>  void do_timer(struct pt_regs *regs)
>  {
> -	jiffies_64++;
> -	update_times();
> +	update_times(++jiffies_64);
>  	softlockup_tick(regs);
>  }
>  

jiffies_64 is not volatile so you should not have to obfuscate
the code like this.

-- 
Send instant messages to your online friends http://au.messenger.yahoo.com 
