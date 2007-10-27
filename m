Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 27 Oct 2007 14:12:42 +0100 (BST)
Received: from sonicwall.montavista.co.jp ([202.232.97.131]:27018 "EHLO
	gateway-1237.mvista.com") by ftp.linux-mips.org with ESMTP
	id S20029833AbXJ0NMe (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 27 Oct 2007 14:12:34 +0100
Received: from localhost.localdomain (g03.jp.mvista.com [10.200.16.48])
	by yuubin.jp.mvista.com (Postfix) with SMTP id 221248054;
	Sat, 27 Oct 2007 22:11:58 +0900 (JST)
Date:	Sat, 27 Oct 2007 22:11:05 +0900
From:	tnishioka <tnishioka@mvista.com>
To:	linux-mips@linux-mips.org
Subject: About the changes in co_timer_ack() function of time.c.
Message-Id: <20071027221105.2329b0e6.tnishioka@mvista.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <tnishioka@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17255
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tnishioka@mvista.com
Precedence: bulk
X-list: linux-mips


Hi all,

I DO know you guys must be very busy always, so I am sorry to disturb you.
I please ask you to let me know the reason why the changes made in co_timer_ack()
function on Mips kernel v2.6.23.1.
Because I got a problem on kernel v2.6.10 that the timer interrupt had ignored rarely
and it causes no updates for "jiffies" for a while (approx. 4min on my board).
And I found the change - a part of your excellent works - on v2.6.23.1
for co_timer_ack() function in time.c.

v2.6.10 kernel:
                /* Check to see if we have missed any timer interrupts.  */
                count = read_c0_count();
                if ((count - expirelo) < 0x7fffffff) {
                        /* missed_timer_count++; */
                        expirelo = count + cycles_per_jiffy;
                        write_c0_compare(expirelo);
                }

v2.6.23.1 kernel:
                /* Check to see if we have missed any timer interrupts.  */
                while (((count = read_c0_count()) - expirelo) < 0x7fffffff) {
                        /* missed_timer_count++; */
                        expirelo = count + cycles_per_jiffy;
                        write_c0_compare(expirelo);
                }

So, I plase ask you a couple of my questions -
1) What kind of phenomena did this change cause ?
2) What is the defect that this part of codes in v2.6.10 kernel has ?
Please let me know.

Thanks,

Best regards,
tnishioka
