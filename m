Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f94IQ0x19414
	for linux-mips-outgoing; Thu, 4 Oct 2001 11:26:00 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f94IPoD19409
	for <linux-mips@oss.sgi.com>; Thu, 4 Oct 2001 11:25:50 -0700
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 16CA8125C8; Thu,  4 Oct 2001 11:25:48 -0700 (PDT)
Date: Thu, 4 Oct 2001 11:25:48 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: Alice Hennessy <ahennessy@mvista.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: BOOTP problem
Message-ID: <20011004112548.A15124@lucon.org>
References: <3BBCA8A8.23CA468F@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BBCA8A8.23CA468F@mvista.com>; from ahennessy@mvista.com on Thu, Oct 04, 2001 at 11:21:28AM -0700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Oct 04, 2001 at 11:21:28AM -0700, Alice Hennessy wrote:
> Hello,
> 
> Just grabbed the latest code and BOOTP doesn't work with the latest
> net/ipv4/ipconfig.c
> (it does work with the ipconfig.c from a 6/11 snapshot).   Anyone else
> having problems?
> 

There was a problem. Try this patch. BTW, I was told it was fixed in
the current kernel.


H.J.
----
--- linux-2.4.5-ac3-ext3/net/ipv4/ipconfig.c.dhcp	Tue May  1 20:59:24 2001
+++ linux-2.4.5-ac3-ext3/net/ipv4/ipconfig.c	Tue May 29 09:30:16 2001
@@ -816,61 +816,63 @@ static int __init ic_bootp_recv(struct s
 		u8 *ext;
 
 #ifdef IPCONFIG_DHCP
+		if (ic_proto_enabled & IC_USE_DHCP) {
 
-		u32 server_id = INADDR_NONE;
-		int mt = 0;
+			u32 server_id = INADDR_NONE;
+			int mt = 0;
 
-		ext = &b->exten[4];
-		while (ext < end && *ext != 0xff) {
-			u8 *opt = ext++;
-			if (*opt == 0)	/* Padding */
-				continue;
-			ext += *ext + 1;
-			if (ext >= end)
-				break;
-			switch (*opt) {
-			case 53:	/* Message type */
-				if (opt[1])
-					mt = opt[2];
-				break;
-			case 54:	/* Server ID (IP address) */
-				if (opt[1] >= 4)
-					memcpy(&server_id, opt + 2, 4);
-				break;
+			ext = &b->exten[4];
+			while (ext < end && *ext != 0xff) {
+				u8 *opt = ext++;
+				if (*opt == 0)	/* Padding */
+					continue;
+				ext += *ext + 1;
+				if (ext >= end)
+					break;
+				switch (*opt) {
+				case 53:	/* Message type */
+					if (opt[1])
+						mt = opt[2];
+					break;
+				case 54:	/* Server ID (IP address) */
+					if (opt[1] >= 4)
+						memcpy(&server_id, opt + 2, 4);
+					break;
+				}
 			}
-		}
 
 #ifdef IPCONFIG_DEBUG
-		printk("DHCP: Got message type %d\n", mt);
+			printk("DHCP: Got message type %d\n", mt);
 #endif
 
-		switch (mt) {
-		    case DHCPOFFER:
-			/* While in the process of accepting one offer,
-			   ignore all others. */
-			if (ic_myaddr != INADDR_NONE)
-				goto drop;
-			/* Let's accept that offer. */
-			ic_myaddr = b->your_ip;
-			ic_servaddr = server_id;
+			switch (mt) {
+			case DHCPOFFER:
+				/* While in the process of accepting one offer,
+				   ignore all others. */
+				if (ic_myaddr != INADDR_NONE)
+					goto drop;
+				/* Let's accept that offer. */
+				ic_myaddr = b->your_ip;
+				ic_servaddr = server_id;
 #ifdef IPCONFIG_DEBUG
-			printk("DHCP: Offered address %u.%u.%u.%u", NIPQUAD(ic_myaddr));
-			printk(" by server %u.%u.%u.%u\n", NIPQUAD(ic_servaddr));
+				printk("DHCP: Offered address %u.%u.%u.%u", NIPQUAD(ic_myaddr));
+				printk(" by server %u.%u.%u.%u\n", NIPQUAD(ic_servaddr));
 #endif
-			break;
+				break;
 
-		    case DHCPACK:
-			/* Yeah! */
-			break;
-
-		    default:
-			/* Urque.  Forget it*/
-			ic_myaddr = INADDR_NONE;
-			ic_servaddr = INADDR_NONE;
-			goto drop;
-		}
+			case DHCPACK:
+				/* Yeah! */
+				break;
+
+			default:
+				/* Urque.  Forget it*/
+				ic_myaddr = INADDR_NONE;
+				ic_servaddr = INADDR_NONE;
+				goto drop;
+			}
 
-		ic_dhcp_msgtype = mt;
+			ic_dhcp_msgtype = mt;
+		}
 
 #endif /* IPCONFIG_DHCP */
 
