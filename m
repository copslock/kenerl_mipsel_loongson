Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1F5xqk07727
	for linux-mips-outgoing; Thu, 14 Feb 2002 21:59:52 -0800
Received: from dea.linux-mips.net (a1as18-p131.stg.tli.de [195.252.193.131])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1F5xl907724
	for <linux-mips@oss.sgi.com>; Thu, 14 Feb 2002 21:59:47 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g1F4uLt25251
	for linux-mips@oss.sgi.com; Fri, 15 Feb 2002 05:56:21 +0100
Date: Fri, 15 Feb 2002 05:56:20 +0100
From: Ralf Baechle <ralf@oss.sgi.com>
To: linux-mips@oss.sgi.com
Subject: Re: ip22 watchdog timer
Message-ID: <20020215055620.A25211@dea.linux-mips.net>
References: <20020208172711.GA5605@bogon.ms20.nix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020208172711.GA5605@bogon.ms20.nix>; from agx@sigxcpu.org on Fri, Feb 08, 2002 at 06:27:11PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Feb 08, 2002 at 06:27:11PM +0100, Guido Guenther wrote:

> attached is an updated patch for the ip22 watchdog timer. Please apply.

Patch doesn't apply cleanly.

***************
*** 574,579 ****
     fi
  # we always need the dummy console to make the serial console I2 happy
     define_bool CONFIG_DUMMY_CONSOLE y
     endmenu
  fi
  
--- 574,584 ----
     fi
  # we always need the dummy console to make the serial console I2 happy
     define_bool CONFIG_DUMMY_CONSOLE y
+    bool 'Watchdog Timer Support'   CONFIG_WATCHDOG
+    if [ "$CONFIG_WATCHDOG" != "n" ]; then
+       bool '  Disable watchdog shutdown on close' CONFIG_WATCHDOG_NOWAYOUT
+       tristate '  Indy/I2 Hardware Watchdog' CONFIG_INDYDOG
+    fi
     endmenu
  fi

Anyway, the comment about the I2 looks suspicious ...

  Ralf
