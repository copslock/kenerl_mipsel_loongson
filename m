Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Mar 2003 11:42:03 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:581 "EHLO
	trasno.mitica") by linux-mips.org with ESMTP id <S8225223AbTCMLmC>;
	Thu, 13 Mar 2003 11:42:02 +0000
Received: by trasno.mitica (Postfix, from userid 1001)
	id 443396EC; Thu, 13 Mar 2003 12:42:02 +0100 (CET)
To: Ladislav Michl <ladis@linux-mips.org>
Cc: Guido Guenther <agx@sigxcpu.org>,
	Vincent =?iso-8859-2?q?Stehl=E9?= <vincent.stehle@stepmind.com>,
	linux-mips@linux-mips.org
Subject: Re: PROM variables
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <20030313113310.GA6151@simek> (Ladislav Michl's message of
 "Thu, 13 Mar 2003 12:33:10 +0100")
References: <3E7057A6.60007@stepmind.com>
	<20030313102601.GD24866@bogon.ms20.nix> <20030313113310.GA6151@simek>
Date: Thu, 13 Mar 2003 12:42:02 +0100
Message-ID: <868yvjjxx1.fsf@trasno.mitica>
User-Agent: Gnus/5.090015 (Oort Gnus v0.15) Emacs/21.2.93
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1724
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips

>>>>> "ladislav" == Ladislav Michl <ladis@linux-mips.org> writes:

ladislav> On Thu, Mar 13, 2003 at 11:26:01AM +0100, Guido Guenther wrote:
ladislav> [snip]
>> > As I doubt there is currently a solution, I was thinking about 
>> > implementing this as a /proc subdir. What do you think ?
>> What about multiple files in /proc/arcs which have the PROM variables as
>> name and its value as contents? 

ladislav> hmm, how would you add/remove variable?

echo "value" > new_variable_name 

??

Later, Juan.


-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
