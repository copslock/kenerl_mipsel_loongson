Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g01NcxC28564
	for linux-mips-outgoing; Tue, 1 Jan 2002 15:38:59 -0800
Received: from sgi.com (sgi-too.SGI.COM [204.94.211.39])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g01Ncug28561
	for <linux-mips@oss.sgi.com>; Tue, 1 Jan 2002 15:38:56 -0800
Received: from hypatia.brisbane.redhat.com (lulu.redhat.com.au [202.83.74.3]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA07115
	for <linux-mips@oss.sgi.com>; Tue, 1 Jan 2002 14:38:19 -0800 (PST)
	mail_from (bje@scooby.brisbane.redhat.com)
Received: from scooby.brisbane.redhat.com (scooby.brisbane.redhat.com [172.16.5.228])
	by hypatia.brisbane.redhat.com (8.11.6/8.11.0) with ESMTP id g01MJdK02713;
	Wed, 2 Jan 2002 08:19:41 +1000
Received: by scooby.brisbane.redhat.com (Postfix, from userid 500)
	id 47C011083B; Wed,  2 Jan 2002 09:19:39 +1100 (EST)
From: Ben Elliston <bje@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15410.13819.197485.322115@scooby.brisbane.redhat.com>
Date: Wed, 2 Jan 2002 09:19:39 +1100 (EST)
To: "H . J . Lu" <hjl@lucon.org>
Cc: Ryan Murray <rmurray@debian.org>, linux-mips@oss.sgi.com
Subject: Re: config.guess changs
In-Reply-To: <20011227095306.A16072@lucon.org>
References: <20011227020844.U29645@cyberhqz.com>
	<20011227095306.A16072@lucon.org>
X-Mailer: VM 6.75 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

>>>>> "H" == H J Lu <hjl@lucon.org> writes:

  >> The config.guess rework of 12/12/2001 doesn't work on big endian machines,
  >> as the preprocessor defines "mips" to be " 1", so the cpp -E output ends
  >> up being "CPU= 1".

  H> Try this patch.

  H> 2001-12-27  H.J. Lu  <hjl@gnu.org>

  H> 	* config.guess (mips:Linux:*:*): Undefine CPU, mips and mipsel
  H> 	first.

Thanks; applied to the FSF master copy.

Ben
