Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBRIrCL27115
	for linux-mips-outgoing; Thu, 27 Dec 2001 10:53:12 -0800
Received: from ocean.lucon.org (12-234-19-19.client.attbi.com [12.234.19.19])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBRIr9X27112
	for <linux-mips@oss.sgi.com>; Thu, 27 Dec 2001 10:53:09 -0800
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 52C57125C3; Thu, 27 Dec 2001 09:53:06 -0800 (PST)
Date: Thu, 27 Dec 2001 09:53:06 -0800
From: "H . J . Lu" <hjl@lucon.org>
To: Ryan Murray <rmurray@debian.org>
Cc: linux-mips@oss.sgi.com, config-patches@gnu.org
Subject: Re: config.guess changs
Message-ID: <20011227095306.A16072@lucon.org>
References: <20011227020844.U29645@cyberhqz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011227020844.U29645@cyberhqz.com>; from rmurray@debian.org on Thu, Dec 27, 2001 at 02:08:44AM -0800
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by oss.sgi.com id fBRIr9X27113
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Dec 27, 2001 at 02:08:44AM -0800, Ryan Murray wrote:
> The config.guess rework of 12/12/2001 doesn't work on big endian machines,
> as the preprocessor defines "mips" to be " 1", so the cpp -E output ends
> up being "CPU= 1".
> 

Try this patch.


H.J.
----
2001-12-27  H.J. Lu  <hjl@gnu.org>

	* config.guess (mips:Linux:*:*): Undefine CPU, mips and mipsel
	first.

--- config.guess	Wed Dec 12 19:53:12 2001
+++ config.guess	Thu Dec 27 09:51:18 2001
@@ -770,6 +770,9 @@ EOF
     mips:Linux:*:*)
 	eval $set_cc_for_build
 	sed 's/^	//' << EOF >$dummy.c
+	#undef CPU
+	#undef mips
+	#undef mipsel
 	#if defined(__MIPSEL__) || defined(__MIPSEL) || defined(_MIPSEL) || defined(MIPSEL) 
 	CPU=mipsel 
 	#else
