Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 27 Jul 2013 16:05:58 +0200 (CEST)
Received: from multi.imgtec.com ([194.200.65.239]:35977 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6819681Ab3G0OFukAhCe (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 27 Jul 2013 16:05:50 +0200
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Markos Chandras <Markos.Chandras@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [ 58/79] lib/Kconfig.debug: Restrict FRAME_POINTER for MIPS
Thread-Topic: [ 58/79] lib/Kconfig.debug: Restrict FRAME_POINTER for MIPS
Thread-Index: AQHOikGIZMC+6l0rxUa3DLV/23Swapl4kD1w
Date:   Sat, 27 Jul 2013 14:05:40 +0000
Message-ID: <0573B2AE5BBFFC408CC8740092293B5A22ABB144@BADAG02.ba.imgtec.org>
References: <20130726204721.849052763@linuxfoundation.org>,<20130726204728.725267852@linuxfoundation.org>
In-Reply-To: <20130726204728.725267852@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: multipart/alternative;
        boundary="_000_0573B2AE5BBFFC408CC8740092293B5A22ABB144BADAG02baimgtec_"
MIME-Version: 1.0
X-SEF-Processed: 7_3_0_01192__2013_07_27_15_05_45
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37381
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Steven.Hill@imgtec.com
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

--_000_0573B2AE5BBFFC408CC8740092293B5A22ABB144BADAG02baimgtec_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Looks good. Thanks Greg.

Acked-by: Steven J. Hill <Steven.Hill@imgtec.com>

Sent from my Verizon Wireless 4G LTE Smartphone


----- Reply message -----
From: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "stable@vger.kernel.=
org" <stable@vger.kernel.org>, "Markos Chandras" <Markos.Chandras@imgtec.co=
m>, "Steven J. Hill" <Steven.Hill@imgtec.com>, "Ralf Baechle" <ralf@linux-m=
ips.org>, "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: [ 58/79] lib/Kconfig.debug: Restrict FRAME_POINTER for MIPS
Date: Fri, Jul 26, 2013 4:48 PM



3.10-stable review patch.  If anyone has any objections, please let me know=
.

------------------

From: Markos Chandras <markos.chandras@imgtec.com>

commit 25c87eae1725ed77a8b44d782a86abdc279b4ede upstream.

FAULT_INJECTION_STACKTRACE_FILTER selects FRAME_POINTER but
that symbol is not available for MIPS.

Fixes the following problem on a randconfig:
warning: (LOCKDEP && FAULT_INJECTION_STACKTRACE_FILTER && LATENCYTOP &&
 KMEMCHECK) selects FRAME_POINTER which has unmet direct dependencies
(DEBUG_KERNEL && (CRIS || M68K || FRV || UML || AVR32 || SUPERH || BLACKFIN=
 ||
MN10300 || METAG) || ARCH_WANT_FRAME_POINTERS)

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
Acked-by: Steven J. Hill <Steven.Hill@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/5441/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 lib/Kconfig.debug |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1272,7 +1272,7 @@ config FAULT_INJECTION_STACKTRACE_FILTER
         depends on FAULT_INJECTION_DEBUG_FS && STACKTRACE_SUPPORT
         depends on !X86_64
         select STACKTRACE
-       select FRAME_POINTER if !PPC && !S390 && !MICROBLAZE && !ARM_UNWIND
+       select FRAME_POINTER if !MIPS && !PPC && !S390 && !MICROBLAZE && !A=
RM_UNWIND
         help
           Provide stacktrace filter for fault-injection capabilities




--_000_0573B2AE5BBFFC408CC8740092293B5A22ABB144BADAG02baimgtec_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from text --><style><!-- .EmailQuote { margin-left: 1pt; pad=
ding-left: 4pt; border-left: #800000 2px solid; } --></style>
</head>
<body>
<style>
<!--
.x_EmailQuote
	{margin-left:1pt;
	padding-left:4pt;
	border-left:#800000 2px solid}
-->
</style>
<div><span style=3D"font-family:Arial">Looks good. Thanks Greg.<br>
<br>
Acked-by: Steven J. Hill &lt;Steven.Hill@imgtec.com&gt;<br>
<br>
Sent from my Verizon Wireless 4G LTE Smartphone<br>
<br>
<br>
<div id=3D"x_htc_header" style=3D"">----- Reply message -----<br>
From: &quot;Greg Kroah-Hartman&quot; &lt;gregkh@linuxfoundation.org&gt;<br>
To: &quot;linux-kernel@vger.kernel.org&quot; &lt;linux-kernel@vger.kernel.o=
rg&gt;<br>
Cc: &quot;Greg Kroah-Hartman&quot; &lt;gregkh@linuxfoundation.org&gt;, &quo=
t;stable@vger.kernel.org&quot; &lt;stable@vger.kernel.org&gt;, &quot;Markos=
 Chandras&quot; &lt;Markos.Chandras@imgtec.com&gt;, &quot;Steven J. Hill&qu=
ot; &lt;Steven.Hill@imgtec.com&gt;, &quot;Ralf Baechle&quot; &lt;ralf@linux=
-mips.org&gt;, &quot;linux-mips@linux-mips.org&quot;
 &lt;linux-mips@linux-mips.org&gt;<br>
Subject: [ 58/79] lib/Kconfig.debug: Restrict FRAME_POINTER for MIPS<br>
Date: Fri, Jul 26, 2013 4:48 PM<br>
<br>
</div>
</span><br>
<br>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">3.10-stable review patch.&nbsp; If anyone has any =
objections, please let me know.<br>
<br>
------------------<br>
<br>
From: Markos Chandras &lt;markos.chandras@imgtec.com&gt;<br>
<br>
commit 25c87eae1725ed77a8b44d782a86abdc279b4ede upstream.<br>
<br>
FAULT_INJECTION_STACKTRACE_FILTER selects FRAME_POINTER but<br>
that symbol is not available for MIPS.<br>
<br>
Fixes the following problem on a randconfig:<br>
warning: (LOCKDEP &amp;&amp; FAULT_INJECTION_STACKTRACE_FILTER &amp;&amp; L=
ATENCYTOP &amp;&amp;<br>
&nbsp;KMEMCHECK) selects FRAME_POINTER which has unmet direct dependencies<=
br>
(DEBUG_KERNEL &amp;&amp; (CRIS || M68K || FRV || UML || AVR32 || SUPERH || =
BLACKFIN ||<br>
MN10300 || METAG) || ARCH_WANT_FRAME_POINTERS)<br>
<br>
Signed-off-by: Markos Chandras &lt;markos.chandras@imgtec.com&gt;<br>
Acked-by: Steven J. Hill &lt;Steven.Hill@imgtec.com&gt;<br>
Cc: linux-mips@linux-mips.org<br>
Patchwork: <a href=3D"https://patchwork.linux-mips.org/patch/5441/">https:/=
/patchwork.linux-mips.org/patch/5441/</a><br>
Signed-off-by: Ralf Baechle &lt;ralf@linux-mips.org&gt;<br>
Signed-off-by: Greg Kroah-Hartman &lt;gregkh@linuxfoundation.org&gt;<br>
<br>
---<br>
&nbsp;lib/Kconfig.debug |&nbsp;&nbsp;&nbsp; 2 &#43;-<br>
&nbsp;1 file changed, 1 insertion(&#43;), 1 deletion(-)<br>
<br>
--- a/lib/Kconfig.debug<br>
&#43;&#43;&#43; b/lib/Kconfig.debug<br>
@@ -1272,7 &#43;1272,7 @@ config FAULT_INJECTION_STACKTRACE_FILTER<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; depends on FAULT_INJECTION=
_DEBUG_FS &amp;&amp; STACKTRACE_SUPPORT<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; depends on !X86_64<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; select STACKTRACE<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; select FRAME_POINTER if !PPC &amp;&am=
p; !S390 &amp;&amp; !MICROBLAZE &amp;&amp; !ARM_UNWIND<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; select FRAME_POINTER if !MIPS &am=
p;&amp; !PPC &amp;&amp; !S390 &amp;&amp; !MICROBLAZE &amp;&amp; !ARM_UNWIND=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; help<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Provide stackt=
race filter for fault-injection capabilities<br>
&nbsp;<br>
<br>
<br>
</div>
</span></font>
</body>
</html>

--_000_0573B2AE5BBFFC408CC8740092293B5A22ABB144BADAG02baimgtec_--
