Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Mar 2003 15:47:21 +0000 (GMT)
Received: from moutvdom.kundenserver.de ([IPv6:::ffff:212.227.126.252]:12242
	"EHLO moutvdom.kundenserver.de") by linux-mips.org with ESMTP
	id <S8225203AbTCGPrU>; Fri, 7 Mar 2003 15:47:20 +0000
Received: from [212.227.126.222] (helo=mrvdomng.kundenserver.de)
	by moutvdom.kundenserver.de with esmtp (Exim 3.35 #1)
	id 18rK46-0003kf-00; Fri, 07 Mar 2003 16:47:18 +0100
Received: from [62.109.119.183] (helo=192.168.202.41)
	by mrvdomng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 18rK45-0008QZ-00; Fri, 07 Mar 2003 16:47:17 +0100
From: Bruno Randolf <br1@4g-systems.de>
Organization: 4G Mobile Systeme
To: Alexander Popov <s_popov@prosyst.bg>
Subject: Re: Mycable XXS board
Date: Fri, 7 Mar 2003 16:47:13 +0100
User-Agent: KMail/1.5
References: <3E689267.3070509@prosyst.bg> <1047040846.10649.10.camel@adsl.pacbell.net>
In-Reply-To: <1047040846.10649.10.camel@adsl.pacbell.net>
Cc: linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_B8La+X0aPWUZE5k"
Message-Id: <200303071647.13275.br1@4g-systems.de>
Return-Path: <br1@4g-systems.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1653
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: br1@4g-systems.de
Precedence: bulk
X-list: linux-mips


--Boundary-00=_B8La+X0aPWUZE5k
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hello!

we are also working with this board and it it supported thru the Pb1500 board 
configuration of the linux-mips.org kernel. we use the 2_4 branch and some 
patches of pete (ftp://ftp.linux-mips.org/pub/linux/mips/people/ppopov). with 
these patches i can already see my pci cards (but i dont yet have a driver 
for them). usb does not yet work - it complains that it cannot assign new 
numbers to the devices. the flash chip (AM29LV641DL) is also not recognized 
yet.

if you dont use YAMON, you have to add a patch to deal with the nonexistent 
command line parameters. i attached it for you, but its an ugly hack.

and to enable one of the ethernet ports you can use the second patch. it's 
also quite a hack, cause it does not yet deal with the second port... 

bruno


On Friday 07 March 2003 13:40, you wrote:
> On Fri, 2003-03-07 at 04:36, Alexander Popov wrote:
> > Hi all,
> >
> > Has anyone used the kernel on a Mycable XXS board ( it has Alchemy au1500
> > )... What CPU type should I choose for the au1500? R5000? Sorry for the
> > lame question but I haven't used MIPS-based boards and I know nothing
> > baout the CPU...
>
> Given that the board has an Alchemy Au1500 CPU, I would say you should
> chose the Au1500 :)  Start with the Pb1500 board port that's in
> linux-mips.org. Maybe, just maybe, a Pb1500 kernel will boot fine on
> your board. And if it doesn't, creating a port for the above mentioned
> board should be fairly easy.
>
> Pete

--Boundary-00=_B8La+X0aPWUZE5k
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="cfc_startup.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="cfc_startup.diff"

--- arch/mips/au1000/common/prom.c	Wed Dec 12 19:30:52 2001
+++ arch/mips/au1000/common/prom.c	Tue Feb  4 00:41:08 2003
@@ -62,21 +62,21 @@
 
 void  prom_init_cmdline(void)
 {
-	char *cp;
-	int actr;
+//	char *cp;
+//	int actr;
 
-	actr = 1; /* Always ignore argv[0] */
+//	actr = 1; /* Always ignore argv[0] */
 
-	cp = &(arcs_cmdline[0]);
-	while(actr < prom_argc) {
-	        strcpy(cp, prom_argv[actr]);
-		cp += strlen(prom_argv[actr]);
-		*cp++ = ' ';
-		actr++;
-	}
-	if (cp != &(arcs_cmdline[0])) /* get rid of trailing space */
-		--cp;
-	*cp = '\0';
+//	cp = &(arcs_cmdline[0]);
+//	while(actr < prom_argc) {
+//	        strcpy(cp, prom_argv[actr]);
+//		cp += strlen(prom_argv[actr]);
+//		*cp++ = ' ';
+//		actr++;
+//	}
+//	if (cp != &(arcs_cmdline[0])) /* get rid of trailing space */
+//		--cp;
+//	*cp = '\0';
 
 }
 
@@ -88,17 +88,17 @@
 	 * Environment variables are stored in the form of "memsize=64".
 	 */
 
-	t_env_var *env = (t_env_var *)prom_envp;
-	int i;
+//	t_env_var *env = (t_env_var *)prom_envp;
+//	int i;
 
-	i = strlen(envname);
+//	i = strlen(envname);
 
-	while(env->name) {
-		if(strncmp(envname, env->name, i) == 0) {
-			return(env->name + strlen(envname) + 1);
-		}
-		env++;
-	}
+//	while(env->name) {
+//		if(strncmp(envname, env->name, i) == 0) {
+//			return(env->name + strlen(envname) + 1);
+//		}
+//		env++;
+//	}
 	return(NULL);
 }
 

--Boundary-00=_B8La+X0aPWUZE5k
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="au1000_eth_BCM5222_hack.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="au1000_eth_BCM5222_hack.diff"

--- ../linux-mips-2_4-cvs-clean/drivers/net/au1000_eth.c	Wed Dec 11 07:12:30 2002
+++ drivers/net/au1000_eth.c	Fri Feb  7 14:37:49 2003
@@ -471,6 +471,7 @@
 } mii_chip_table[] = {
 	{"Broadcom BCM5201 10/100 BaseT PHY",  0x0040, 0x6212, &bcm_5201_ops },
 	{"Broadcom BCM5221 10/100 BaseT PHY",  0x0040, 0x61e4, &bcm_5201_ops },
+	{"Broadcom BCM5222 10/100 BaseT PHY",  0x0040, 0x6322, &bcm_5201_ops },
 	{"AMD 79C901 HomePNA PHY",  0x0000, 0x35c8, &am79c901_ops },
 	{"AMD 79C874 10/100 BaseT PHY",  0x0022, 0x561b, &am79c874_ops },
 	{"LSI 80227 10/100 BaseT PHY", 0x0016, 0xf840, &lsi_80227_ops },

--Boundary-00=_B8La+X0aPWUZE5k--
