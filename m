Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8AGFlb21062
	for linux-mips-outgoing; Mon, 10 Sep 2001 09:15:47 -0700
Received: from dea.linux-mips.net (u-120-18.karlsruhe.ipdial.viaginterkom.de [62.180.18.120])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8AGFfd21048
	for <linux-mips@oss.sgi.com>; Mon, 10 Sep 2001 09:15:42 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id f8A9JkJ06544;
	Mon, 10 Sep 2001 11:19:46 +0200
Date: Mon, 10 Sep 2001 11:19:46 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Carsten Langgaard <carstenl@mips.com>
Cc: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>, linux-mips@oss.sgi.com
Subject: Re: setup_frame() failure
Message-ID: <20010910111946.A6479@dea.linux-mips.net>
References: <20010907.202652.71083122.nemoto@toshiba-tops.co.jp> <20010908013638.A19154@dea.linux-mips.net> <3B9C6B81.94FB616@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B9C6B81.94FB616@mips.com>; from carstenl@mips.com on Mon, Sep 10, 2001 at 09:28:02AM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Sep 10, 2001 at 09:28:02AM +0200, Carsten Langgaard wrote:

> I like the printout then getting a Reserved Instruction Exception, it
> indicates a problem and things are much easier to debug when getting
> such messages.  So it would be a pity, if we need to get rid of that.

A denial of service can be constructed from such printout, so this can't
stay in an release version.  Think of what

#include <signal.h>

static void si(void) { }

int main(int argc, char *argv[])
{
        signal(SIGILL, sh);

        while(1)
                asm volatile("mfc0 $0, $0");
}

would do if each exception would result in a line in syslog.

  Ralf
