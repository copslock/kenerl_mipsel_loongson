Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Apr 2003 19:24:59 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:9462 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225072AbTDHSY6>;
	Tue, 8 Apr 2003 19:24:58 +0100
Received: from mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id LAA07801;
	Tue, 8 Apr 2003 11:24:46 -0700
Message-ID: <3E9313ED.53DCC96E@mvista.com>
Date: Tue, 08 Apr 2003 12:24:45 -0600
From: Michael Pruznick <michael_pruznick@mvista.com>
Reply-To: michael_pruznick@mvista.com
Organization: MontaVista
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Justin Carlson <justinca@cs.cmu.edu>
CC: "Avinash S." <avinash.s@inspiretech.com>,
	linux <linux-mips@linux-mips.org>
Subject: Re: printk problems
References: <200304081211.h38CBgf6024962@smtp.inspirtek.com> <1049816267.17005.25.camel@gs256.sp.cs.cmu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <michael_pruznick@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1944
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: michael_pruznick@mvista.com
Precedence: bulk
X-list: linux-mips


> Until this point, printk() calls are buffered in memory. 

This is what I like to use to bypass the buffering for
non-standard serial hardware.  

The raw_output() function needs to be specific to
your serial driver.  The one below is just an example
from a board I'm currently working on (that is not in
the linux-mips tree yet).  Basically, raw_output() needs
to put the char in the serial hardware output register
and then wait for the serial hardware to indicate that
it put the char on the wire to prevent over-run.


Changes to kernel/printk.c
#define RAW_OUTPUT
static void emit_log_char(char c)
{
#ifdef RAW_OUTPUT
        void raw_output(char c);
        raw_output(c);
#else
        LOG_BUF(log_end) = c;
        log_end++;
        if (log_end - log_start > LOG_BUF_LEN)
                log_start = log_end - LOG_BUF_LEN;
        if (log_end - con_start > LOG_BUF_LEN)
                con_start = log_end - LOG_BUF_LEN;
        if (logged_chars < LOG_BUF_LEN)
                logged_chars++;
#endif
}


What I added to my serial driver.  You will need to
do the similar for your specific serial hardware.
#ifdef RAW_OUTPUT
void raw_output(char c)
{
        struct rs_port *port = &rs_ports[0];
        if ( c == '\n' )
        {
          sio_out(port, TXX9_SITFIFO, '\r');
          wait_for_xmitr(port);
        }
        sio_out(port, TXX9_SITFIFO, c);
        wait_for_xmitr(port);
        return;
}
#endif


-- 
Michael Pruznick, michael_pruznick@mvista.com, www.mvista.com
MontaVista Software, 1237 East Arques Ave, Sunnyvale, CA 94085
